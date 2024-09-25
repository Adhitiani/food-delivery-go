package repository

import "project/food-delivery/model"

type UserRepository interface {
	InsertUser(user model.SignupUser) error
}
