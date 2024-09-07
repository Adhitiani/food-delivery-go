package postgres

import (
	"database/sql"
	"fmt"
	"project/food-delivery/model"

	"github.com/lib/pq"
)

type MenuItemRespository struct {
	db *sql.DB
}

func NewMenuItemRepository(db *sql.DB) *MenuItemRespository {
	return &MenuItemRespository{db: db}
}

func (m MenuItemRespository) GetAllSuppliersId() ([]int, error) {
	rows, err := m.db.Query(`SELECT external_id FROM suppliers`)
	if err != nil {
		return []int{}, fmt.Errorf("error executing query: %v", err)
	}

	defer rows.Close()

	var suppliersId []int

	for rows.Next() {
		var id int

		if err := rows.Scan(&id); err != nil {
			return nil, fmt.Errorf("error scanning row: %v", err)
		}

		suppliersId = append(suppliersId, id)

	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("error iterating over rows: %v", err)
	}

	return suppliersId, nil

}

func (m MenuItemRespository) InsertMenuItem(menuItems []model.MenuItem) error {

	//prepare the sql query
	stmt, err := m.db.Prepare(`INSERT INTO menu_items (external_id, name, price, image, type, ingredients, supplier_id) VALUES ($1, $2, $3, $4, $5, $6, $7) ON CONFLICT (external_id) DO UPDATE SET price = EXCLUDED.price`)

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

//func GetAllMenusItem()
