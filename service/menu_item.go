package service

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"project/food-delivery/model"
	"project/food-delivery/repository"
	"project/food-delivery/util"
	"time"
)

type MenuItemService struct {
	repo         repository.MenuItemRepository
	supplierRepo repository.SupplierRepository
}

func NewMenuItemService(repo repository.MenuItemRepository, supplierRepo repository.SupplierRepository) *MenuItemService {
	return &MenuItemService{
		repo:         repo,
		supplierRepo: supplierRepo,
	}
}

func (m *MenuItemService) FetchMenuItem() ([]model.MenuItem, error) {
	//bypass the tls security
	//get all the suppliers Id
	// iterate over the suppliers id
	// in each iteration pass in the current id to the menu url
	// fetch the data from the menu
	// store it in responseMenu type
	// append it in the responseAllmenu a slice of menu

	client := util.CreateInsecureClient()
	if m.supplierRepo == nil {
		return nil, fmt.Errorf("supplierRepo is not initialized")
	}
	if m.repo == nil {
		return nil, fmt.Errorf("menuItemRepo is not initialized")
	}

	Ids, err := m.supplierRepo.GetAllSuppliersId()
	if err != nil {
		return nil, fmt.Errorf("error get all supplier id: %v", err)
	}

	var allMenusItems []model.MenuItem
	for _, id := range Ids {
		url := fmt.Sprintf("https://foodapi.golang.nixdev.co/suppliers/%d/menu", id)

		resp, err := client.Get(url)
		if err != nil {
			return nil, fmt.Errorf("error fetching data: %v", err)
		}

		defer resp.Body.Close()

		body, err := io.ReadAll(resp.Body)
		if err != nil {
			return nil, fmt.Errorf("error reading body %v", err)
		}

		var menuItems model.MenuResponse

		err = json.Unmarshal(body, &menuItems)
		if err != nil {
			return nil, fmt.Errorf("error unmarshalling data %v", err)
		}

		// Add supplier ID to each menu item
		for i := range menuItems.Menu {
			menuItems.Menu[i].SupplierId = id
		}

		allMenusItems = append(allMenusItems, menuItems.Menu...)
	}
	//log.Printf("menu items : %v", allMenusItems)
	log.Printf("total menu items : %d", len(allMenusItems))
	return allMenusItems, nil

}

func (m *MenuItemService) FetchAndInsertMenuItem() error {
	allMenusItems, err := m.FetchMenuItem()
	if err != nil {
		log.Fatalf("error fetching menuItem: %v", err)
	}

	err = m.repo.InsertMenuItem(allMenusItems)
	if err != nil {
		log.Fatalf("error inserting menuItem to database: %v", err)
	}
	//log.Println("MenuItem inserted into the database successfully!")
	return nil
}

func (m *MenuItemService) PriceUpdater() {
	go func() {
		for {
			m.FetchAndInsertMenuItem()
			log.Println("Price Update successfully")

			time.Sleep(60 * time.Minute)
		}
	}()
}

func (m *MenuItemService) GetMenuItemBySupplierId(id int) ([]*model.MenuItem, error) {
	return m.repo.GetMenuItemBySupplierId(id)
}
