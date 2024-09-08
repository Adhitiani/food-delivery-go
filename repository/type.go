package repository

import "project/food-delivery/model"

type Type interface {
	GetAllType() ([]*model.Type, error)
}
