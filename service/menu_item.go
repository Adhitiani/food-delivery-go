package service

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"project/food-delivery/model"
	"project/food-delivery/repository"
	"project/food-delivery/util"
	"project/food-delivery/util/pool"
	"time"
)

type MenuItemService struct {
	menuRepo     repository.MenuItemRepository
	supplierRepo repository.SupplierRepository
}

func NewMenuItemService(repo repository.MenuItemRepository, supplierRepo repository.SupplierRepository) *MenuItemService {
	return &MenuItemService{
		menuRepo:     repo,
		supplierRepo: supplierRepo,
	}
}

func (m *MenuItemService) FetchAndInsertMenuItem() error {
	// Fetch supplier IDs
	Ids, err := m.supplierRepo.GetSuppliersIdAndExternalId()
	if err != nil {
		return fmt.Errorf("error getting supplier IDs: %v", err)
	}

	const maxWorkers = 3
	resCh := make(chan any)
	errCh := make(chan error)

	// Create worker pool
	wPool := pool.NewWorkerPool(resCh, errCh).WithBrokerCount(maxWorkers)
	wPool.Start()

	// Append jobs to worker pool for each supplier
	for _, supplier := range Ids {
		supplier := supplier // Capture supplier variable in the closure
		wPool.Append(func() (any, error) {
			url := fmt.Sprintf("https://foodapi.golang.nixdev.co/suppliers/%d/menu", supplier.ExternalId)
			menuItems, err := m.FetchMenuForSupplier(url, supplier.Id)
			if err != nil {
				return nil, err
			}
			return menuItems, nil
		})
	}

	// Collect results in a separate goroutine
	go func() {
		for res := range resCh {
			menuItems := res.([]model.MenuItem)
			err := m.menuRepo.InsertMenuItems(menuItems)
			if err != nil {
				errCh <- err
			}
		}
	}()

	// Shutdown the worker pool
	go func() {
		wPool.Shutdown() // This will close resCh and errCh
		close(errCh)     // Close error channel after worker pool shuts down
	}()

	// Handle errors
	var errors []error
	for err := range errCh {
		errors = append(errors, err)
	}

	if len(errors) > 0 {
		log.Printf("Errors occurred while fetching or inserting menu items: %v", errors)
		return fmt.Errorf("errors occurred while fetching or inserting menu items: %v", errors)
	}

	log.Println("Successfully finished fetching and inserting menu items")
	return nil
}

// FetchMenuForSupplier fetches menu items for a specific supplier
func (m *MenuItemService) FetchMenuForSupplier(url string, supplierId int) ([]model.MenuItem, error) {
	client := util.CreateInsecureClient()
	resp, err := client.Get(url)
	if err != nil {
		return nil, fmt.Errorf("error fetching data from URL: %v", err)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("error reading body: %v", err)
	}

	var menuItems model.MenuResponse
	if err := json.Unmarshal(body, &menuItems); err != nil {
		return nil, fmt.Errorf("error unmarshalling data: %v", err)
	}

	// Add supplier ID to each menu item
	for i := range menuItems.Menu {
		menuItems.Menu[i].SupplierId = supplierId
	}

	return menuItems.Menu, nil
}

// func (m *MenuItemService) FetchMenuItem() ([]model.MenuItem, error) {

// 	client := util.CreateInsecureClient()
// 	if m.supplierRepo == nil {
// 		return nil, fmt.Errorf("supplierRepo is not initialized")
// 	}
// 	if m.menuRepo == nil {
// 		return nil, fmt.Errorf("menuItemRepo is not initialized")
// 	}

// 	Ids, err := m.supplierRepo.GetSuppliersIdAndExternalId()
// 	if err != nil {
// 		return nil, fmt.Errorf("error get all supplier id: %v", err)
// 	}

// 	var allMenusItems []model.MenuItem
// 	for _, supplier := range Ids {
// 		url := fmt.Sprintf("https://foodapi.golang.nixdev.co/suppliers/%d/menu", supplier.ExternalId)

// 		resp, err := client.Get(url)
// 		if err != nil {
// 			return nil, fmt.Errorf("error fetching data: %v", err)
// 		}

// 		defer resp.Body.Close()

// 		body, err := io.ReadAll(resp.Body)
// 		if err != nil {
// 			return nil, fmt.Errorf("error reading body %v", err)
// 		}

// 		var menuItems model.MenuResponse

// 		err = json.Unmarshal(body, &menuItems)
// 		if err != nil {
// 			return nil, fmt.Errorf("error unmarshalling data %v", err)
// 		}

// 		// Add supplier ID to each menu item
// 		for i := range menuItems.Menu {
// 			menuItems.Menu[i].SupplierId = supplier.Id
// 		}

// 		allMenusItems = append(allMenusItems, menuItems.Menu...)
// 	}
// 	//log.Printf("menu items : %v", allMenusItems)
// 	log.Printf("total menu items : %d", len(allMenusItems))
// 	return allMenusItems, nil

// }

// func (m *MenuItemService) FetchAndInsertMenuItem() error {
// 	allMenusItems, err := m.FetchMenuItem()
// 	if err != nil {
// 		log.Fatalf("error fetching menuItem: %v", err)
// 	}

// 	err = m.menuRepo.InsertMenuItems(allMenusItems)
// 	if err != nil {
// 		log.Fatalf("error inserting menuItem to database: %v", err)
// 	}
// 	//log.Println("MenuItem inserted into the database successfully!")
// 	return nil
// }

func (m *MenuItemService) PriceAndSupplierUpdater(supplierService *SupplierService) {
	// Function to run updates and measure execution time
	runUpdates := func() {
		start := time.Now() // Start timing

		// Update suppliers
		if err := supplierService.FetchAndInsertSuppliers(); err != nil {
			log.Printf("Error updating suppliers: %v", err)
		} else {
			log.Println("Suppliers update successfully completed")
		}

		// Update menu items
		if err := m.FetchAndInsertMenuItem(); err != nil {
			log.Printf("Error updating menu items: %v", err)
		} else {
			log.Println("Price update successfully completed")
		}

		elapsed := time.Since(start) // Calculate elapsed time
		log.Printf("runUpdates completed in %v", elapsed)
	}

	// Run immediately when the server starts
	runUpdates()

	// Start ticker for periodic updates
	ticker := time.NewTicker(10 * time.Minute)
	defer ticker.Stop()

	go func() {
		for range ticker.C {
			// Run updates every 10 minutes and log how long they take
			runUpdates()
		}
	}()
}

func (m *MenuItemService) GetMenuItemBySupplierId(id int) ([]*model.MenuItem, error) {
	return m.menuRepo.GetMenuItemBySupplierId(id)
}
