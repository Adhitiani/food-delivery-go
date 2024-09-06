package service

//get only Id from the database

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"project/food-delivery/model"
	"project/food-delivery/repository"
	"project/food-delivery/util"
)

type MenuItemService struct {
	repo repository.MenuItemRepository
}

func NewMenuItemService(repo repository.MenuItemRepository) *MenuItemService {
	return &MenuItemService{repo: repo}
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

	Ids, err := m.repo.GetAllSuppliersId()
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
			menuItems.Menu[i].SupplierId = id // Set the SupplierID field
		}

		allMenusItems = append(allMenusItems, menuItems.Menu...)
	}
	log.Printf("menu items : %v", allMenusItems)
	log.Printf("total menu items : %d", len(allMenusItems))
	return allMenusItems, nil

}

// func GetAllSuppliersId() ([]int, error) {
// 	// Set up PostgreSQL connection
// 	connStr := "user=food_delivery_user password=password123 dbname=food_delivery sslmode=disable"
// 	db, err := sql.Open("postgres", connStr)
// 	if err != nil {
// 		log.Fatalf("error connecting to the database: %v", err)
// 	}
// 	defer db.Close()

// 	rows, err := db.Query(`SELECT external_id AS id FROM suppliers ORDER BY external_id`)
// 	if err != nil {
// 		return []int{}, fmt.Errorf("error executing query: %v", err)
// 	}

// 	defer rows.Close()

// 	var suppliersId []int

// 	for rows.Next() {
// 		var id int

// 		if err := rows.Scan(&id); err != nil {
// 			return nil, fmt.Errorf("error scanning row: %v", err)
// 		}

// 		suppliersId = append(suppliersId, id)

// 	}

// 	if err := rows.Err(); err != nil {
// 		return nil, fmt.Errorf("error iterating over rows: %v", err)
// 	}

// 	log.Printf("Supplier id total: %d, %v", len(suppliersId), suppliersId)
// 	return suppliersId, nil

// }
