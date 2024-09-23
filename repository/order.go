package repository

import "project/food-delivery/model"

type OrderRepository interface {
	CreateOrder(order model.Order) error
	GetOrderDetailsById(orderID int) (*model.Order, error)
}
