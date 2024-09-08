package handler

import (
	"encoding/json"
	"fmt"
	"net/http"
	"project/food-delivery/service"
	"strconv"
)

func GetAllSuppliersHandler(supplierService *service.SupplierService) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		// Fetch all suppliers from the database
		suppliers, err := supplierService.GetAllSuppliers()
		if err != nil {
			http.Error(w, fmt.Sprintf("Error fetching suppliers: %v", err), http.StatusInternalServerError)
			return
		}

		//log.Printf("suppliers handlers: %v", suppliers)

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

func GetSupplierByIdHandler(supplierService *service.SupplierService) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		// get the id from Url path
		id, err := strconv.Atoi(r.PathValue("id"))
		if err != nil || id < 1 {
			http.Error(w, "Invalid ID", http.StatusBadRequest)
			return
		}

		supplier, err := supplierService.GetSupplierById(id)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error get suppliers by id: %d, %v", id, err), http.StatusInternalServerError)
			return
		}

		// Convert the suppliers to JSON
		jsonData, err := json.Marshal(supplier)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error marshalling supplier to JSON: %v", err), http.StatusInternalServerError)
			return
		}

		// Write the JSON data to the response
		w.Header().Set("Content-Type", "application/json")
		_, err = w.Write(jsonData)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error writing JSON response: %v", err), http.StatusInternalServerError)
			return
		}
	}

}
