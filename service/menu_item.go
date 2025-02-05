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

	Ids, err := m.supplierRepo.GetSuppliersIdAndExternalId()
	if err != nil {
		return fmt.Errorf("error getting supplier IDs: %v", err)
	}

	const maxWorkers = 3
	resCh := make(chan any)
	errCh := make(chan error)

	wPool := pool.NewWorkerPool(resCh, errCh).WithBrokerCount(maxWorkers)
	wPool.Start()

	for _, supplier := range Ids {
		supplier := supplier
		wPool.Append(func() (any, error) {
			url := fmt.Sprintf("https://foodapi.golang.nixdev.co/suppliers/%d/menu", supplier.ExternalId)
			menuItems, err := m.FetchMenuForSupplier(url, supplier.Id)
			if err != nil {
				return nil, err
			}
			return menuItems, nil
		})
	}

	go func() {
		for res := range resCh {
			menuItems := res.([]model.MenuItem)
			err := m.menuRepo.InsertMenuItems(menuItems)
			if err != nil {
				errCh <- err
			}
		}
	}()

	go func() {
		wPool.Shutdown()
		close(errCh)
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

func (m *MenuItemService) PriceAndSupplierUpdater(supplierService *SupplierService) {

	runUpdates := func() {
		start := time.Now()

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

		elapsed := time.Since(start)
		log.Printf("runUpdates completed in %v", elapsed)
	}

	runUpdates()

	ticker := time.NewTicker(10 * time.Minute)
	defer ticker.Stop()

	go func() {
		for range ticker.C {
			runUpdates()
		}
	}()
}

func (m *MenuItemService) GetMenuItemBySupplierId(id int) ([]*model.MenuItem, error) {
	return m.menuRepo.GetMenuItemBySupplierId(id)
}
