package repository

import "project/food-delivery/model"

type OrderRepository interface {
	CreateOrder(order model.Order) error
	GetOrderDetails(orderID int) (*model.Order, error)
}
