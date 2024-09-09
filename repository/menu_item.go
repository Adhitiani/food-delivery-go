package repository

import "project/food-delivery/model"

type MenuItemRepository interface {
	InsertMenuItem([]model.MenuItem) error
	GetMenuItemBySupplierId(id int) ([]*model.MenuItem, error)
}
