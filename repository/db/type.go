package postgres

import (
	"database/sql"
	"fmt"
	"project/food-delivery/model"
)

type TypeRepository struct {
	db *sql.DB
}

func NewTypeRepository(db *sql.DB) *TypeRepository {
	return &TypeRepository{db: db}
}

func (t *TypeRepository) GetAllType() ([]*model.Type, error) {
	//prepare sql query
	// call sql Query method on statment as it will return more than one rows
	// create Type variable to hold all the type data
	//iterate row with Next adn in each iteration scan it
	// push the scan result to Types variable
	// return the type variables

	query := `SELECT id, name FROM menu_types ORDER BY name`

	stmt, err := t.db.Prepare(query)
	if err != nil {
		return nil, fmt.Errorf("error preparing statment: %v", err)
	}
	defer stmt.Close()

	rows, err := stmt.Query()
	if err != nil {
		return nil, fmt.Errorf("error executing query: %v", err)
	}
	defer rows.Close()

	var types []*model.Type

	for rows.Next() {
		var typeCategory model.Type
		err = rows.Scan(&typeCategory.Id, &typeCategory.Name)
		if err != nil {
			return nil, fmt.Errorf("error scanning row: %v", err)
		}
		types = append(types, &typeCategory)
	}

	// Check for errors that may have occurred during iteration
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("error during rows iteration: %v", err)
	}

	return types, nil

}

func (r *TypeRepository) GetOrInsertMenuType(menuType string) (int, error) {
	var menuTypeId int
	// First, check if the menu type already exists
	query := `SELECT id FROM menu_types WHERE name = $1`
	err := r.db.QueryRow(query, menuType).Scan(&menuTypeId)
	if err == sql.ErrNoRows {
		// If the menu type does not exist, insert it
		insertQuery := `INSERT INTO menu_types (name) VALUES ($1) RETURNING id`
		err = r.db.QueryRow(insertQuery, menuType).Scan(&menuTypeId)
		if err != nil {
			return 0, fmt.Errorf("failed to insert menu type: %v", err)
		}
	} else if err != nil {
		return 0, fmt.Errorf("failed to get menu type: %v", err)
	}

	return menuTypeId, nil
}
