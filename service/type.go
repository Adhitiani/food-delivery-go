package service

import (
	"project/food-delivery/model"
	"project/food-delivery/repository"
)

type TypeService struct {
	repo repository.Type
}

func NewTypeRepository(repo repository.Type) *TypeService {
	return &TypeService{repo: repo}
}

func (t *TypeService) GetAllType() ([]*model.Type, error) {
	return t.repo.GetAllType()
}
