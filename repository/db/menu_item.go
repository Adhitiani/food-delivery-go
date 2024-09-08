package postgres

import (
	"database/sql"
	"fmt"
	"log"
	"project/food-delivery/model"

	"github.com/lib/pq"
)

type MenuItemRespository struct {
	db *sql.DB
}

func NewMenuItemRepository(db *sql.DB) *MenuItemRespository {
	return &MenuItemRespository{db: db}
}

// func (m MenuItemRespository) GetAllSuppliersId() ([]int, error) {
// 	rows, err := m.db.Query(`SELECT external_id FROM suppliers`)
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

// 	return suppliersId, nil
// }

func (m MenuItemRespository) InsertMenuItem(menuItems []model.MenuItem) error {
	//prepare the sql query
	query := `INSERT INTO menu_items (external_id, name, price, image, type, ingredients, supplier_id) VALUES ($1, $2, $3, $4, $5, $6, $7) ON CONFLICT (external_id) DO UPDATE SET price = EXCLUDED.price`

	stmt, err := m.db.Prepare(query)

	if err != nil {
		return fmt.Errorf("error preparing statment: %v", err)
	}

	defer stmt.Close()

	for _, menuItem := range menuItems {
		_, err = stmt.Exec(menuItem.ID, menuItem.Name, menuItem.Price, menuItem.Image, menuItem.Type, pq.Array(menuItem.Ingredients), menuItem.SupplierId)
		if err != nil {
			return fmt.Errorf("error inserting menuItem %v %v", menuItem.Name, err)
		}
	}

	return nil
}

func (m *MenuItemRespository) GetAllMenusItem() ([]*model.MenuItem, error) {
	//prepare the query
	query := `SELECT external_id, name, price, image, type, ingredients, supplier_id FROM menu_items`
	stmt, err := m.db.Prepare(query)
	if err != nil {
		return nil, fmt.Errorf("error preparing statment: %v", err)
	}

	defer stmt.Close()

	rows, err := stmt.Query()
	if err != nil {
		return nil, fmt.Errorf("error executing query: %v", err)
	}

	defer rows.Close()

	var menuItems []*model.MenuItem

	for rows.Next() {
		menuItem := &model.MenuItem{}
		err = rows.Scan(&menuItem.ID, &menuItem.Name, &menuItem.Price, &menuItem.Image, &menuItem.Type, pq.Array(&menuItem.Ingredients), &menuItem.SupplierId)

		if err != nil {
			return nil, fmt.Errorf("error scanning row: %v", err)
		}
		menuItems = append(menuItems, menuItem)
	}
	// Check for errors after iterating over the rows
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("rows error: %v", err)
	}

	return menuItems, nil

}

func (m *MenuItemRespository) GetMenuItemBySupplierId(id int) ([]*model.MenuItem, error) {
	//prepare the query
	query := `SELECT id, name, price, image, type, ingredients, supplier_id FROM menu_items WHERE supplier_id = $1`

	stmt, err := m.db.Prepare(query)
	if err != nil {
		return nil, fmt.Errorf("error in preparing db statment: %v", err)
	}
	defer stmt.Close()

	rows, err := stmt.Query(id)
	if err != nil {
		return nil, fmt.Errorf("error executing query: %v", err)
	}
	defer rows.Close()

	var menuItems []*model.MenuItem
	rowCount := 0

	for rows.Next() {
		menuItem := &model.MenuItem{}
		err = rows.Scan(&menuItem.ID, &menuItem.Name, &menuItem.Price, &menuItem.Image, &menuItem.Type, pq.Array(&menuItem.Ingredients), &menuItem.SupplierId)

		if err != nil {
			return nil, fmt.Errorf("error scanning row: %v", err)
		}
		menuItems = append(menuItems, menuItem)
		rowCount++
	}

	// Check for errors after iterating over the rows
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("rows error: %v", err)
	}

	log.Printf("Total menu items fetched: %d", rowCount)
	//log.Printf("Menu items data: %+v", menuItems)
	return menuItems, nil

}
