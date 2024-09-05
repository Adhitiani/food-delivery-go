package main

import (
	"crypto/tls"
	"database/sql"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"

	_ "github.com/lib/pq"
)

// Create an HTTP client that skips SSL verification
func createInsecureClient() *http.Client {
	// Create a custom Transport that disables SSL verification
	transport := &http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}

	return &http.Client{Transport: transport}
}

// create struct type to store the data
type WorkingHours struct {
	Opening string `json:"opening"`
	Closing string `json:"closing"`
}

type Supplier struct {
	Id           int          `json:"id"`
	Name         string       `jason:"name"`
	Type         string       `json:"type"`
	Image        string       `json:"image"`
	WorkingHours WorkingHours `json:"workinghours"`
}

type SuppliersResponse struct {
	Suppliers []Supplier
}

// fetchsupplier funciton
// since the certificate is not workng use the create insecure client function to
// bypass the tls to fetch the data
func FetchSuppliers(url string, limit, page int) ([]Supplier, error) {
	client := createInsecureClient()

	resp, err := client.Get(url)
	if err != nil {
		return nil, fmt.Errorf("error fetching data: %v", err)
	}

	//close the connection after all the surroundg function finish
	defer resp.Body.Close()

	// need to read the body response in order to use unmarshal to convert Json to struct

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("error reading body: %v", err)
	}

	// create  a variable supplierresponse type to store the result of the converted Json

	var result SuppliersResponse

	// convert the bytes to SuppliersResponse struct

	err = json.Unmarshal(body, &result)
	if err != nil {
		return nil, fmt.Errorf("error unmarshaling data: %v", err)
	}

	// return the Suppliers field from the result struct

	return result.Suppliers, nil

}

func InsertSuppliersToDb(db *sql.DB, suppliers []Supplier) error {
	stmt, err := db.Prepare(`
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

func GetAllSuppliers(db *sql.DB) ([]Supplier, error) {
	stmt, err := db.Prepare(`SELECT id, name, type, image, opening_time, closing_time FROM suppliers ORDER BY id`)
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
	var suppliers []Supplier

	// Iterate through the result set and scan each row into a Supplier struct
	for rows.Next() {
		var supplier Supplier
		var openingTime, closingTime string

		err := rows.Scan(&supplier.Id, &supplier.Name, &supplier.Type, &supplier.Image, &openingTime, &closingTime)
		if err != nil {
			return nil, fmt.Errorf("error scanning row: %v", err)
		}

		// Set the working hours
		supplier.WorkingHours = WorkingHours{
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

	return suppliers, nil
}

func suppliersHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		// Fetch all suppliers from the database
		suppliers, err := GetAllSuppliers(db)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error fetching suppliers: %v", err), http.StatusInternalServerError)
			return
		}

		// Convert the suppliers to JSON
		w.Header().Set("Content-Type", "application/json")
		jsonData, err := json.Marshal(suppliers)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error marshalling suppliers to JSON: %v", err), http.StatusInternalServerError)
			return
		}

		// Write the JSON data to the response
		_, err = w.Write(jsonData)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error writing JSON response: %v", err), http.StatusInternalServerError)
			return
		}
	}
}

// Middleware to handle CORS
func corsMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*") // Allow all origins; adjust as needed
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

		if r.Method == http.MethodOptions {
			return
		}

		next.ServeHTTP(w, r)
	})
}

func main() {
	// Set up PostgreSQL connection
	connStr := "user=food_delivery_user password=password123 dbname=food_delivery sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("error connecting to the database: %v", err)
	}
	defer db.Close()

	limit := 20
	page := 1

	var allSuppliers []Supplier

	// since the data can't be fetch all in one time use loop
	for {
		//create dynamic url
		url := fmt.Sprintf("https://foodapi.golang.nixdev.co/suppliers?limit=%d&page=%d", limit, page)

		suppliers, err := FetchSuppliers(url, limit, page)
		if err != nil {
			log.Fatalf("error fetching supplier: %v", err)
		}

		// if there is no more suppliers result exit the loop
		if len(suppliers) == 0 {
			break
		}

		//append the suppliers from the current iteration to allSuppliers
		allSuppliers = append(allSuppliers, suppliers...)

		//increment the page for next iteration
		page++
	}

	log.Println("Total Suppliers Fetched:", len(allSuppliers))

	// Insert all fetched suppliers into the database
	err = InsertSuppliersToDb(db, allSuppliers)
	if err != nil {
		log.Fatalf("error inserting suppliers to database: %v", err)
	}

	log.Println("Suppliers inserted into the database successfully!")

	// Create an HTTP server using the default ServeMux

	mux := http.NewServeMux()
	mux.HandleFunc("/suppliers", suppliersHandler(db))

	// Wrap the mux with CORS middleware
	handler := corsMiddleware(mux)

	log.Println("Starting server on :8080")
	if err := http.ListenAndServe(":8080", handler); err != nil {
		log.Fatalf("Server failed: %v", err)
	}

}
