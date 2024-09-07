package repository

import "project/food-delivery/model"

type MenuItemRepository interface {
	GetAllSuppliersId() ([]int, error)
	InsertMenuItem([]model.MenuItem) error
}
