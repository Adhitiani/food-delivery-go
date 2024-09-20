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
	// Prepare the query
	query := `SELECT id, name, price, image, menu_type_id, ingredients, supplier_id FROM menu_items WHERE supplier_id = $1`

	stmt, err := m.db.Prepare(query)
	if err != nil {
		return nil, fmt.Errorf("error preparing db statement: %v", err)
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
		var menuTypeId *int
		err = rows.Scan(&menuItem.ID, &menuItem.Name, &menuItem.Price, &menuItem.Image, &menuTypeId, pq.Array(&menuItem.Ingredients), &menuItem.SupplierId)
		if err != nil {
			return nil, fmt.Errorf("error scanning row: %v", err)
		}

		if menuTypeId != nil {
			// Convert menu_type_id to menu type string if needed
			menuItem.Type = m.GetMenuTypeById(*menuTypeId)
		} else {
			menuItem.Type = "" // or handle NULL case as needed
		}

		menuItems = append(menuItems, menuItem)
		rowCount++
	}

	// Check for errors after iterating over the rows
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("rows error: %v", err)
	}

	log.Printf("Total menu items fetched: %d", rowCount)
	log.Printf("Menu items data: %+v", menuItems)
	return menuItems, nil
}

func (m *MenuItemRespository) InsertMenuItems(menuItems []model.MenuItem) error {
	// Prepare the SQL query
	query := `
        INSERT INTO menu_items (external_id, supplier_id, name, price, image, ingredients, menu_type_id)
        VALUES ($1, $2, $3, $4, $5, $6, $7)
        ON CONFLICT (external_id) DO UPDATE 
        SET name = EXCLUDED.name, price = EXCLUDED.price, image = EXCLUDED.image, 
            ingredients = EXCLUDED.ingredients, menu_type_id = EXCLUDED.menu_type_id
    `
	stmt, err := m.db.Prepare(query)
	if err != nil {
		return fmt.Errorf("error preparing statement: %v", err)
	}
	defer stmt.Close()

	for _, item := range menuItems {
		// Ensure menuTypeId is fetched or derived correctly
		menuTypeId, err := m.GetOrInsertMenuType(item.Type) // Implement this function to map `Type` to `menu_type_id`
		if err != nil {
			return fmt.Errorf("error getting or inserting menu type: %v", err)
		}

		_, err = stmt.Exec(
			item.ID,                    // 1. external_id
			item.SupplierId,            // 2. supplier_id
			item.Name,                  // 3. name
			item.Price,                 // 4. price
			item.Image,                 // 5. image
			pq.Array(item.Ingredients), // 6. ingredients (as an array)
			menuTypeId,                 // 7. menu_type_id
		)
		if err != nil {
			return fmt.Errorf("error inserting menu item %v: %v", item.Name, err)
		}
	}
	return nil
}

// func (m *MenuItemRespository) GetOrInsertMenuType(menuType string) (int, error) {
// 	var menuTypeId int
// 	// First, check if the menu type already exists
// 	query := `SELECT id FROM menu_types WHERE name = $1`
// 	err := m.db.QueryRow(query, menuType).Scan(&menuTypeId)
// 	if err == sql.ErrNoRows {
// 		// If the menu type does not exist, insert it
// 		insertQuery := `INSERT INTO menu_types (name) VALUES ($1) RETURNING id`
// 		err = m.db.QueryRow(insertQuery, menuType).Scan(&menuTypeId)
// 		if err != nil {
// 			return 0, fmt.Errorf("failed to insert menu type: %v", err)
// 		}
// 	} else if err != nil {
// 		return 0, fmt.Errorf("failed to get menu type: %v", err)
// 	}

// 	return menuTypeId, nil
// }

func (m *MenuItemRespository) GetOrInsertMenuType(menuType string) (int, error) {
	var menuTypeId int

	// Try to retrieve the existing menu type ID
	err := m.db.QueryRow(`SELECT id FROM menu_types WHERE name = $1`, menuType).Scan(&menuTypeId)
	if err == sql.ErrNoRows {
		// If not found, insert a new menu type
		err = m.db.QueryRow(`INSERT INTO menu_types (name) VALUES ($1) RETURNING id`, menuType).Scan(&menuTypeId)
		if err != nil {
			return 0, fmt.Errorf("error inserting menu type: %v", err)
		}
	} else if err != nil {
		return 0, fmt.Errorf("error retrieving menu type id: %v", err)
	}

	return menuTypeId, nil
}

func (m *MenuItemRespository) GetMenuTypeById(id int) string {
	var menuType string
	err := m.db.QueryRow(`SELECT name FROM menu_types WHERE id = $1`, id).Scan(&menuType)
	if err != nil {
		log.Printf("error retrieving menu type by id: %v", err)
		return ""
	}
	return menuType
}
