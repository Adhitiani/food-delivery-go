package repository

import (
	"project/food-delivery/model"
)

type SupplierRepository interface {
	InsertSuppliers(suppliers []model.Supplier) error
	GetAllSuppliers() ([]model.Supplier, error)
	GetSupplierById(id int) (*model.Supplier, error)
}
