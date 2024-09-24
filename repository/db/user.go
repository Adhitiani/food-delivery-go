package postgres

import (
	"database/sql"
	"project/food-delivery/model"
)

// Define a UserRespository struct which wraps a database conneciton pool.
type UserRepository struct {
	db *sql.DB
}

func NewUserRepository(db *sql.DB) *UserRepository {
	return &UserRepository{db: db}
}

func (u *UserRepository) InsertUser(user model.User) error {

}
