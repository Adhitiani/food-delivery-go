package repository

import (
	"project/food-delivery/model"
)

type SupplierRepository interface {
	InsertSuppliers(suppliers []model.Supplier) error
	GetAllSuppliers() ([]*model.Supplier, error)
	GetSupplierById(id int) (*model.Supplier, error)
	DoesSupplierExist(id int) (bool, error)
	GetAllSuppliersId() ([]int, error)
	GetSuppliersIdAndExternalId() ([]model.SupplierIds, error)
	GetSupplierByMenuType(menuType string) ([]*model.Supplier, error)
	GetSupplierCategories(supplierId int) ([]*model.Type, error)
}
