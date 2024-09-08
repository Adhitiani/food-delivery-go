package handler

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"project/food-delivery/service"
	"strconv"
)

func GetMenuItemBySupplierIdHandler(menuItemService *service.MenuItemService, supplierService *service.SupplierService) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		//extrac the id from url
		id, err := strconv.Atoi(r.PathValue("id"))
		//log.Printf("id %d", id)

		if err != nil || id < 1 {
			http.Error(w, "Invalid ID", http.StatusBadRequest)
			return
		}

		//check if the supplier id does exist
		exists, err := supplierService.DoesSupplierExist(id)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error checking supplier: %v", err), http.StatusInternalServerError)
			return
		}
		if !exists {
			http.Error(w, fmt.Sprintf("Supplier with ID %d does not exist.", id), http.StatusNotFound)
			return
		}

		// Fetch menu items by supplier ID
		menuItems, err := menuItemService.GetMenuItemBySupplierId(id)
		if err != nil {
			http.Error(w, "Failed to fetch menu items", http.StatusInternalServerError)
			return
		}

		// Handle case where no menu items are found
		if len(menuItems) == 0 {
			log.Printf("No menu items found for supplier ID: %d", id)
			w.WriteHeader(http.StatusNotFound)
			json.NewEncoder(w).Encode(map[string]string{"message": "No menu items found"})
			return
		}

		// return menuItems as Json response
		w.Header().Set("Content-Type", "application/json")
		jsonMenus, err := json.Marshal(menuItems)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error marshalling MenuItems to JSON: %v", err), http.StatusInternalServerError)
			return
		}

		//write the Json data to response
		_, err = w.Write(jsonMenus)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error writing JSON response: %v", err), http.StatusInternalServerError)
			return
		}
	}
}
