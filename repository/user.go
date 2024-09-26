package repository

import "project/food-delivery/model"

type UserRepository interface {
	InsertUser(user model.SignupUser) (int, error)
	GetUserById(userId int) (*model.User, error)
	GetUserByEmail(email string) (*model.User, error)
}
