package service

import (
	"project/food-delivery/model"
	"project/food-delivery/repository"
)

type OrderService struct {
	repo repository.OrderRepository
}

func NewOrderService(repo repository.OrderRepository) *OrderService {
	return &OrderService{repo: repo}
}

func (o *OrderService) CreateOrder(order model.Order) (int, error) {
	return o.repo.CreateOrder(order)
}

func (o *OrderService) GetOrderDetailsById(orderID int) (*model.Order, error) {
	return o.repo.GetOrderDetailsById(orderID)
}

func (o *OrderService) GetOrdersByUserId(userId int) ([]model.Order, error) {
	return o.repo.GetOrdersByUserId(userId)
}
