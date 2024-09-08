package postgres

import (
	"database/sql"
	"fmt"
	"log"
	"project/food-delivery/model"
)

// SupplierDbRepository is a structure that holds a database connection, and this connection will be used to perform database operations.
type SupplierDbRepository struct {
	db *sql.DB
}

// NewSupplierDbRepositry is a constructor function that create a new SupplierDbRepository with a given database connection.
func NewSupplierDbRepository(db *sql.DB) *SupplierDbRepository {
	return &SupplierDbRepository{db: db}
}

func (r *SupplierDbRepository) InsertSuppliers(suppliers []model.Supplier) error {
	// prepare the sql query
	stmt, err := r.db.Prepare(`
		INSERT INTO suppliers (external_id, name, type, image, opening_time, closing_time)
		VALUES ($1, $2, $3, $4, $5, $6)
		ON CONFLICT (external_id) DO UPDATE 
		SET external_id = EXCLUDED.external_id, name = EXCLUDED.name, type = EXCLUDED.type, image = EXCLUDED.image, 
		    opening_time = EXCLUDED.opening_time, closing_time = EXCLUDED.closing_time
	`)
	if err != nil {
		return fmt.Errorf("error preparing statement: %v", err)
	}

	defer stmt.Close()

	for _, supplier := range suppliers {
		_, err := stmt.Exec(supplier.Id, supplier.Name, supplier.Type, supplier.Image, supplier.WorkingHours.Opening, supplier.WorkingHours.Closing)
		if err != nil {
			return fmt.Errorf("error inserting supplier %v %v", supplier.Name, err)
		}
	}
	return nil
}

func (r *SupplierDbRepository) GetAllSuppliers() ([]*model.Supplier, error) {
	stmt, err := r.db.Prepare(`SELECT external_id, name, type, image, opening_time, closing_time FROM suppliers ORDER BY external_id`)
	if err != nil {
		return nil, fmt.Errorf("error preparing statement: %v", err)
	}

	defer stmt.Close()

	rows, err := stmt.Query()

	if err != nil {
		return nil, fmt.Errorf("error executing query: %v", err)
	}
	defer rows.Close()

	var suppliers []*model.Supplier

	for rows.Next() {
		supplier := &model.Supplier{}
		var openingTime, closingTime string

		err := rows.Scan(&supplier.Id, &supplier.Name, &supplier.Type, &supplier.Image, &openingTime, &closingTime)
		if err != nil {
			return nil, fmt.Errorf("error scanning row: %v", err)
		}

		// Set the working hours in the supplier struct
		supplier.WorkingHours = model.WorkingHours{
			Opening: openingTime,
			Closing: closingTime,
		}

		// Append the supplier to the slice
		suppliers = append(suppliers, supplier)
	}

	// Check for errors during row iteration
	if err = rows.Err(); err != nil {
		return nil, fmt.Errorf("error iterating rows: %v", err)
	}

	// Return the slice of suppliers

	log.Printf("Finish Get all supliers with total: %d suppliers", len(suppliers))

	return suppliers, nil
}

func (r *SupplierDbRepository) DoesSupplierExist(id int) (bool, error) {
	var exists bool
	query := `SELECT EXISTS(SELECT 1 FROM suppliers WHERE external_id = $1)`

	// Execute query to check if the supplier exists
	err := r.db.QueryRow(query, id).Scan(&exists)
	if err != nil {
		return false, fmt.Errorf("error checking supplier existence: %v", err)
	}

	return exists, nil
}

func (r *SupplierDbRepository) GetSupplierById(id int) (*model.Supplier, error) {
	// Log and check if the supplier exists
	log.Printf("Checking if supplier exists with ID: %d", id)
	exists, err := r.DoesSupplierExist(id)
	if err != nil {
		return nil, fmt.Errorf("error checking supplier: %v", err)
	}
	if !exists {
		return nil, fmt.Errorf("supplier by ID %d does not exist", id)
	}

	// Directly use QueryRow without Prepare
	var supplier model.Supplier
	var openingTime, closingTime string

	err = r.db.QueryRow(`SELECT external_id, name, type, image, opening_time, closing_time FROM suppliers WHERE external_id = $1`, id).Scan(
		&supplier.Id, &supplier.Name, &supplier.Type, &supplier.Image, &openingTime, &closingTime)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, fmt.Errorf("no supplier found with id: %d", id)
		}
		return nil, fmt.Errorf("error in scanning row: %v", err)
	}

	// Set the working hours in the Supplier struct
	supplier.WorkingHours = model.WorkingHours{
		Opening: openingTime,
		Closing: closingTime,
	}

	// Log the supplier after fetching
	log.Printf("Get a supplier by ID: %d, supplier: %v", id, supplier)

	return &supplier, nil
}

func (r *SupplierDbRepository) GetAllSuppliersId() ([]int, error) {
	rows, err := r.db.Query(`SELECT external_id FROM suppliers`)
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
