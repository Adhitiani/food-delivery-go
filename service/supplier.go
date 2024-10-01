package service

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"log"
	"math"
	"project/food-delivery/model"
	"project/food-delivery/repository"
	"project/food-delivery/util"
	"project/food-delivery/util/pool"
	"syscall"
	"time"
)

type SupplierService struct {
	repo repository.SupplierRepository
}

func NewSupplierService(repo repository.SupplierRepository) *SupplierService {
	return &SupplierService{repo: repo}
}

func (s *SupplierService) FetchSuppliers(url string) ([]model.Supplier, error) {
	// Bypass the TLS security
	client := util.CreateInsecureClient()

	// Retry mechanism with memory error handling
	for retry := 0; retry < 3; retry++ {
		resp, err := client.Get(url)
		if err != nil {
			if errors.Is(err, syscall.ENOMEM) {
				log.Printf("Memory error: %v, retrying after a pause...", err)
				time.Sleep(5 * time.Second) // Pause before retrying
				continue
			}
			return nil, fmt.Errorf("error fetching data: %v", err)
		}
		defer resp.Body.Close()

		body, err := io.ReadAll(resp.Body)
		if err != nil {
			if errors.Is(err, syscall.ENOMEM) {
				log.Printf("Memory error reading body: %v, retrying after a pause...", err)
				time.Sleep(5 * time.Second)
				continue
			}
			return nil, fmt.Errorf("error reading body: %v", err)
		}

		var result model.SuppliersResponse

		// Convert the bytes to SuppliersResponse struct
		err = json.Unmarshal(body, &result)
		if err != nil {
			return nil, fmt.Errorf("error unmarshaling data: %v", err)
		}

		var suppliers []model.Supplier
		for _, apiSupplier := range result.Suppliers {
			supplier := s.mapApiSupplierToSupplier(apiSupplier)
			suppliers = append(suppliers, supplier)
		}

		// Return the suppliers field from the result struct
		return suppliers, nil
	}

	return nil, fmt.Errorf("failed to fetch suppliers after retries")
}

func (s *SupplierService) mapApiSupplierToSupplier(apiSupplier model.ApiSupplier) model.Supplier {
	return model.Supplier{
		ExternalId:  apiSupplier.Id,
		Name:        apiSupplier.Name,
		Type:        apiSupplier.Type,
		Image:       apiSupplier.Image,
		OpeningTime: apiSupplier.WorkingHours.Opening,
		ClosingTime: apiSupplier.WorkingHours.Closing,
	}
}

// func (s *SupplierService) FetchAndInsertSuppliers() error {
// 	start := time.Now() // record start time
// 	defer func() {
// 		log.Printf("Time taken: %v\n,", time.Since(start))
// 	}()

// 	limit := 20
// 	page := 1

// 	var allSuppliers []model.Supplier

// 	// since the data can't be fetch all in one time use loop
// 	for {
// 		//create dynamic url
// 		url := fmt.Sprintf("https://foodapi.golang.nixdev.co/suppliers?limit=%d&page=%d", limit, page)

// 		suppliers, err := s.FetchSuppliers(url)
// 		if err != nil {
// 			log.Fatalf("error fetching supplier: %v", err)
// 		}

// 		// if there is no more suppliers result exit the loop
// 		if len(suppliers) == 0 {
// 			break
// 		}

// 		//append the suppliers from the current iteration to allSuppliers
// 		allSuppliers = append(allSuppliers, suppliers...)

// 		page++
// 	}

// 	log.Println("Total Suppliers Fetched:", len(allSuppliers))

// 	// Insert all fetched suppliers into the database
// 	err := s.repo.InsertSuppliers(allSuppliers)
// 	if err != nil {
// 		log.Fatalf("error inserting suppliers to database: %v", err)
// 	}

// 	log.Println("Suppliers inserted into the database successfully!")

// 	return nil

// }

//const maxWorkers = 3

// func (s *SupplierService) FetchAndInsertSuppliers() error {
// 	start := time.Now()
// 	defer func() {
// 		log.Printf("Time taken: %v\n", time.Since(start)) // Log time taken
// 	}()

// 	limit := 20
// 	page := 1

// 	var allSuppliers []model.Supplier
// 	var wg sync.WaitGroup
// 	supplierCh := make(chan []model.Supplier)
// 	errCh := make(chan error)
// 	doneCh := make(chan struct{})

// 	// Launch a goroutine to collect suppliers from the supplierCh
// 	go func() {
// 		for suppliers := range supplierCh {
// 			allSuppliers = append(allSuppliers, suppliers...)
// 		}
// 		// Signal that all suppliers have been collected
// 		doneCh <- struct{}{}
// 	}()

// 	// Start workers to fetch suppliers concurrently
// 	for i := 0; i < maxWorkers; i++ {
// 		wg.Add(1)
// 		go func(page int) {
// 			defer wg.Done()
// 			for {
// 				url := fmt.Sprintf("https://foodapi.golang.nixdev.co/suppliers?limit=%d&page=%d", limit, page)

// 				suppliers, err := s.FetchSuppliers(url)
// 				if err != nil {
// 					errCh <- fmt.Errorf("error fetching supplier at page %d: %v", page, err)
// 					return
// 				}

// 				// If there are no more suppliers, break the loop
// 				if len(suppliers) == 0 {
// 					break
// 				}

// 				// Send the fetched suppliers to the channel
// 				supplierCh <- suppliers

// 				page++
// 			}
// 		}(page)
// 	}

// 	// Wait for all workers to finish
// 	go func() {
// 		wg.Wait()
// 		close(supplierCh)
// 	}()

// 	// Listen for errors and results
// 	select {
// 	case err := <-errCh:
// 		return err
// 	case <-doneCh:
// 		// Insert all fetched suppliers into the database
// 		err := s.repo.InsertSuppliers(allSuppliers)
// 		if err != nil {
// 			return fmt.Errorf("error inserting suppliers into database: %v", err)
// 		}
// 		log.Println("Suppliers inserted into the database successfully!")
// 	}

// 	return nil
// }

func (s *SupplierService) FetchAndInsertSuppliers() error {
	start := time.Now()
	defer func() {
		log.Printf("Time taken: %v\n", time.Since(start))
	}()

	const numSuppliers = 104
	const limit = 20
	const maxWorkers = 3
	var totalPages = int(math.Ceil(float64(numSuppliers) / float64(limit)))

	suppliersResult := make([]model.Supplier, 0)
	resCh := make(chan any)
	errCh := make(chan error)

	wPool := pool.NewWorkerPool(resCh, errCh).WithBrokerCount(maxWorkers)
	wPool.Start()

	// Append jobs for each page
	for page := 1; page <= totalPages; page++ {
		page := page // capture the current page
		log.Printf("Appending job for page %d", page)
		wPool.Append(func() (any, error) {
			url := fmt.Sprintf("https://foodapi.golang.nixdev.co/suppliers?limit=%d&page=%d", limit, page)
			suppliers, err := s.FetchSuppliers(url)
			if err != nil {
				return nil, fmt.Errorf("error fetching page %d: %w", page, err)
			}
			return suppliers, nil // Return the suppliers as `any`
		})
	}

	// Collect results
	go func() {
		for res := range resCh {
			suppliers := res.([]model.Supplier) // Cast `any` to `[]model.Supplier`
			log.Printf("Received suppliers for a page, appending to result")
			suppliersResult = append(suppliersResult, suppliers...)
			log.Printf("Total number of suppliers fetched: %d", len(suppliersResult))
		}
	}()

	// Collect errors and close channels after all results are processed
	go func() {
		wPool.Shutdown() // This will close resCh and errCh
		close(errCh)     // Close error channel after worker pool shuts down
	}()

	// Collect errors
	var errors []error
	for err := range errCh {
		errors = append(errors, err)
	}

	// Check for errors
	if len(errors) > 0 {
		log.Printf("Errors occurred while fetching suppliers: %v", errors)
		return fmt.Errorf("errors occurred while fetching suppliers: %v", errors)
	}

	// Verify the total number of suppliers fetched
	log.Printf("Total number of suppliers fetched: %d", len(suppliersResult))

	// Insert suppliers into the database
	log.Println("Inserting suppliers into the database")
	log.Printf("Attempting to insert %d suppliers into the database...", len(suppliersResult))

	if err := s.repo.InsertSuppliers(suppliersResult); err != nil {
		log.Printf("Failed to insert suppliers: %v", err)
		return err
	}

	log.Println("Successfully finished fetching and inserting suppliers")

	return nil
}

func (s *SupplierService) SupplierUpdater(ctx context.Context) {
	//do initial fetch of supplier when the program start
	if err := s.FetchAndInsertSuppliers(); err != nil {
		log.Printf("Initial supplier fetch failed: %v", err)
	}

	//Create a new ticker that ticks every 10 minutes
	ticker := time.NewTicker(10 * time.Minute)
	defer ticker.Stop()

	for {
		select {
		case <-ctx.Done():
			log.Println("Supplier Updated stopped.")
			return
		case <-ticker.C:
			//in each tick, fetch and insert supplier
			err := s.FetchAndInsertSuppliers()
			if err != nil {
				log.Printf("Error fetching and inserting supplier: %v", err)
			}
		}
	}
}

func (s *SupplierService) GetAllSuppliers() ([]*model.Supplier, error) {
	return s.repo.GetAllSuppliers()
}

func (s *SupplierService) GetSupplierById(id int) (*model.Supplier, error) {
	return s.repo.GetSupplierById(id)
}

func (s *SupplierService) DoesSupplierExist(id int) (bool, error) {
	return s.repo.DoesSupplierExist(id)
}

func (s *SupplierService) GetSupplierByMenuType(menuType string) ([]*model.Supplier, error) {
	return s.repo.GetSupplierByMenuType(menuType)
}
func (s *SupplierService) GetSupplierCategories(supplierId int) ([]*model.Type, error) {
	return s.repo.GetSupplierCategories(supplierId)
}

// 2024/09/23 10:02:54 Errors occurred while fetching suppliers: [error fetching page 5: error fetching data: Get "https://foodapi.golang.nixdev.co/suppliers?limit=20&page=5": dial tcp 88.99.80.40:443: connect: cannot allocate memory error fetching page 4: error fetching data: Get "https://foodapi.golang.nixdev.co/suppliers?limit=20&page=4": dial tcp 88.99.80.40:443: connect: cannot allocate memory]
// 2024/09/23 10:02:54 Time taken: 351.092042ms
// 2024/09/23 10:02:54 Initial supplier fetch failed: errors occurred while fetching suppliers: [error fetching page 5: error fetching data: Get "https://foodapi.golang.nixdev.co/suppliers?limit=20&page=5": dial tcp 88.99.80.40:443: connect: cannot allocate memory error fetching page 4: error fetching data: Get "https://foodapi.golang.nixdev.co/suppliers?limit=20&page=4": dial tcp 88.99.80.40:443: connect: cannot allocate memory]
