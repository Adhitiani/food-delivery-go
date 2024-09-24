package repository

import "project/food-delivery/model"

type OrderRepository interface {
	CreateOrder(order model.Order) (int, error)
	GetOrderDetailsById(orderID int) (*model.Order, error)
}
