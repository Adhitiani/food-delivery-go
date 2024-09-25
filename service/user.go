package service

import (
	"project/food-delivery/model"
	"project/food-delivery/repository"
)

type UserService struct {
	userRepo repository.UserRepository
}

func NewUserService(repo repository.UserRepository) *UserService {
	return &UserService{userRepo: repo}
}

func (u *UserService) InsertUser(user model.SignupUser) error {
	return u.userRepo.InsertUser(user)
}

func (u *UserService) GetUserByEmail(email string) (*model.User, error) {
	return u.userRepo.GetUserByEmail(email)
}

func (u *UserService) GetUserById(userId int) (*model.User, error) {
	return u.userRepo.GetUserById(userId)
}
