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
		page := page
		log.Printf("Appending job for page %d", page)
		wPool.Append(func() (any, error) {
			url := fmt.Sprintf("https://foodapi.golang.nixdev.co/suppliers?limit=%d&page=%d", limit, page)
			suppliers, err := s.FetchSuppliers(url)
			if err != nil {
				return nil, fmt.Errorf("error fetching page %d: %w", page, err)
			}
			return suppliers, nil
		})
	}

	// Collect results
	go func() {
		for res := range resCh {
			suppliers := res.([]model.Supplier)
			log.Printf("Received suppliers for a page, appending to result")
			suppliersResult = append(suppliersResult, suppliers...)
			log.Printf("Total number of suppliers fetched: %d", len(suppliersResult))
		}
	}()

	// Collect errors and close channels after all results are processed
	go func() {
		wPool.Shutdown()
		close(errCh)
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

	log.Printf("Total number of suppliers fetched: %d", len(suppliersResult))

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

	if err := s.FetchAndInsertSuppliers(); err != nil {
		log.Printf("Initial supplier fetch failed: %v", err)
	}

	ticker := time.NewTicker(10 * time.Minute)
	defer ticker.Stop()

	for {
		select {
		case <-ctx.Done():
			log.Println("Supplier Updated stopped.")
			return
		case <-ticker.C:

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
