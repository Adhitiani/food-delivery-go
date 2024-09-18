package service

import (
	"context"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"project/food-delivery/model"
	"project/food-delivery/repository"
	"project/food-delivery/util"
	"sync"
	"time"
)

type SupplierService struct {
	repo repository.SupplierRepository
}

func NewSupplierService(repo repository.SupplierRepository) *SupplierService {
	return &SupplierService{repo: repo}
}

func (s *SupplierService) FetchSuppliers(url string) ([]model.Supplier, error) {
	//bypass the tls security
	client := util.CreateInsecureClient()

	resp, err := client.Get(url)
	if err != nil {
		return nil, fmt.Errorf("error fetching data: %v", err)
	}
	defer resp.Body.Close()

	// need to read the body response in order to use unmarshal to convert Json to struct
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("error reading body: %v", err)
	}

	var result model.SuppliersResponse

	// convert the bytes to SuppliersResponse struct
	err = json.Unmarshal(body, &result)
	if err != nil {
		return nil, fmt.Errorf("error unmarshaling data: %v", err)
	}

	// return the Suppliers field from the result struct

	return result.Suppliers, nil

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

const maxWorkers = 3

func (s *SupplierService) FetchAndInsertSuppliers() error {
	start := time.Now()
	defer func() {
		log.Printf("Time taken: %v\n", time.Since(start)) // Log time taken
	}()

	limit := 20
	page := 1

	var allSuppliers []model.Supplier
	var wg sync.WaitGroup
	supplierCh := make(chan []model.Supplier)
	errCh := make(chan error)
	doneCh := make(chan struct{})

	// Launch a goroutine to collect suppliers from the supplierCh
	go func() {
		for suppliers := range supplierCh {
			allSuppliers = append(allSuppliers, suppliers...)
		}
		// Signal that all suppliers have been collected
		doneCh <- struct{}{}
	}()

	// Start workers to fetch suppliers concurrently
	for i := 0; i < maxWorkers; i++ {
		wg.Add(1)
		go func(page int) {
			defer wg.Done()
			for {
				url := fmt.Sprintf("https://foodapi.golang.nixdev.co/suppliers?limit=%d&page=%d", limit, page)

				suppliers, err := s.FetchSuppliers(url)
				if err != nil {
					errCh <- fmt.Errorf("error fetching supplier at page %d: %v", page, err)
					return
				}

				// If there are no more suppliers, break the loop
				if len(suppliers) == 0 {
					break
				}

				// Send the fetched suppliers to the channel
				supplierCh <- suppliers

				page++
			}
		}(page)
	}

	// Wait for all workers to finish
	go func() {
		wg.Wait()
		close(supplierCh)
	}()

	// Listen for errors and results
	select {
	case err := <-errCh:
		return err
	case <-doneCh:
		// Insert all fetched suppliers into the database
		err := s.repo.InsertSuppliers(allSuppliers)
		if err != nil {
			return fmt.Errorf("error inserting suppliers into database: %v", err)
		}
		log.Println("Suppliers inserted into the database successfully!")
	}

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
