package handler

import (
	"encoding/json"
	"fmt"
	"net/http"
	"project/food-delivery/model"
	"project/food-delivery/service"
)

func CreateOrder(orderService *service.OrderService) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var order model.Order

		//Decode the request body to the order struct
		err := json.NewDecoder(r.Body).Decode(&order)
		if err != nil {
			http.Error(w, "Invalid request payload", http.StatusBadRequest)
			return
		}

		//call the service to create order
		err = orderService.CreateOrder(order)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error creating order %v", err), http.StatusInternalServerError)
			return
		}

		w.Header().Set("Content_Type", "application/json")
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode("Order created successfully")
	}
}
