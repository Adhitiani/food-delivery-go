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
	stmt, err := r.db.Prepare(`SELECT id, name, type, image, opening_time, closing_time FROM suppliers ORDER BY id`)
	if err != nil {
		return nil, fmt.Errorf("error preparing statement: %v", err)
	}

	defer stmt.Close()

	rows, err := stmt.Query()

	if err != nil {
		return nil, fmt.Errorf("error executing query: %v", err)
	}
	defer rows.Close()

	// Create a slice to hold the suppliers
	var suppliers []*model.Supplier

	// Iterate through the result set and scan each row into a Supplier struct
	for rows.Next() {
		// Create a new Supplier pointer for each row
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
	query := `SELECT EXISTS(SELECT 1 FROM suppliers WHERE id = $1)`

	// Execute query to check if the supplier exists
	err := r.db.QueryRow(query, id).Scan(&exists)
	if err != nil {
		return false, fmt.Errorf("error checking supplier existence: %v", err)
	}

	return exists, nil
}

// GetSupplierById fetches a supplier from the database by its ID and returns it.
func (r *SupplierDbRepository) GetSupplierById(id int) (*model.Supplier, error) {
	// Check if the supplier exists
	exists, err := r.DoesSupplierExist(id)
	if err != nil {
		return nil, fmt.Errorf("error checking supplier: %v", err)
	}
	if !exists {
		return nil, fmt.Errorf("supplier by ID %d does not exist: %v", id, err)
	}

	//prepare the sql query
	stmt, err := r.db.Prepare(`SELECT id, name, type, image, opening_time, closing_time FROM suppliers  WHERE id =$1`)
	if err != nil {
		return nil, fmt.Errorf("error in preparing db statment: %v", err)
	}
	defer stmt.Close()

	var supplier model.Supplier
	var openingTime, closingTime string

	err = stmt.QueryRow(id).Scan(&supplier.Id, &supplier.Name, &supplier.Type, &supplier.Image, &openingTime, &closingTime)
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

	log.Printf("Get a supliers by id: %d, supplier: %v", id, supplier)

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
