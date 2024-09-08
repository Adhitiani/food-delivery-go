package handler

import (
	"encoding/json"
	"fmt"
	"net/http"
	"project/food-delivery/service"
)

func GetAllTypeHandler(typeService *service.TypeService) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		//fetch all type from database

		types, err := typeService.GetAllType()
		if err != nil {
			http.Error(w, fmt.Sprintf("Error fetching types: %v", err), http.StatusInternalServerError)
			return
		}

		//convert the data to json
		w.Header().Set("Content-Type", "application/json")
		jsonTypes, err := json.Marshal(types)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error marshalling types to JSON: %v", err), http.StatusInternalServerError)
			return
		}

		//Write Json to response

		_, err = w.Write(jsonTypes)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error writing JSON response: %v", err), http.StatusInternalServerError)
			return
		}
	}
}
