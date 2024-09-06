package postgres

import (
	"database/sql"
	"fmt"
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

//func GetAllMenusItem()
