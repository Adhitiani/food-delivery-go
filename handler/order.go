package handler

import (
	"encoding/json"
	"fmt"
	"net/http"
	"project/food-delivery/model"
	"project/food-delivery/service"
	"strconv"
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
		orderId, err := orderService.CreateOrder(order)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error creating order %v", err), http.StatusInternalServerError)
			return
		}

		response := map[string]interface{}{
			"message": "Order created successfully",
			"orderId": orderId,
		}

		w.Header().Set("Content_Type", "application/json")
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(response)
	}
}

func GetOrderDetailsById(orderService *service.OrderService) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		//extract the ID from url
		id, err := strconv.Atoi(r.PathValue("id"))
		if err != nil || id < 1 {
			http.Error(w, "Invalid ID", http.StatusBadRequest)
			return
		}

		//get the struct type Order
		order, err := orderService.GetOrderDetailsById(id)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error get order by id: %d, %v", id, err), http.StatusInternalServerError)
			return
		}

		//convert order struct to Json
		jsonData, err := json.Marshal(order)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error marshalling order to JSON: %v", err), http.StatusInternalServerError)
			return
		}

		//write Json data to response
		w.Header().Set("Content-Type", "appliaction/json")
		_, err = w.Write(jsonData)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error writing JSON response: %v", err), http.StatusInternalServerError)
			return
		}
	}
}
