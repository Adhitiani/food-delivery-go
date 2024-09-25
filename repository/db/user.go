package postgres

import (
	"database/sql"
	"fmt"
	"log"
	"project/food-delivery/model"

	"github.com/lib/pq"
	"golang.org/x/crypto/bcrypt"
)

// Define a UserRespository struct which wraps a database conneciton pool.
type UserRepository struct {
	db *sql.DB
}

func NewUserRepository(db *sql.DB) *UserRepository {
	return &UserRepository{db: db}
}

func (u *UserRepository) InsertUser(user model.SignupUser) error {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(user.Password), 12)
	if err != nil {
		return fmt.Errorf("error hashing paswword")
	}

	stmt, err := u.db.Prepare("INSERT INTO users(name, email, hashed_password) VALUES ($1, $2, $3)")
	if err != nil {
		return fmt.Errorf("error preparing query")
	}
	defer stmt.Close()

	_, err = stmt.Exec(user.Name, user.Email, string(hashedPassword))
	if err != nil {
		log.Printf("Error executing statement: %v", err) // Log this error
		// Check for Postgres-specific unique constraint violation error
		if pqerr, ok := err.(*pq.Error); ok {
			// Check for constraint violation and specific field
			if pqerr.Code == "23505" && pqerr.Constraint == "users_email_key" {
				return fmt.Errorf("email_already_exists")
			}
		}
		// Handle other errors
		return err
	}
	return nil
}
