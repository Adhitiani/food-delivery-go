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

func (u *UserRepository) InsertUser(user model.SignupUser) (int, error) {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(user.Password), 12)
	if err != nil {
		return 0, fmt.Errorf("error hashing paswword: %v", err)
	}

	stmt, err := u.db.Prepare("INSERT INTO users(name, email, hashed_password) VALUES ($1, $2, $3) RETURNING id")
	if err != nil {
		return 0, fmt.Errorf("error preparing query: %v", err)
	}
	defer stmt.Close()

	var userID int

	err = stmt.QueryRow(user.Name, user.Email, string(hashedPassword)).Scan(&userID)
	if err != nil {
		log.Printf("Error executing statement: %v", err)

		// Check for Postgres-specific unique constraint violation error
		if pqerr, ok := err.(*pq.Error); ok {
			if pqerr.Code == "23505" && pqerr.Constraint == "users_email_key" {
				return 0, fmt.Errorf("email_already_exists")
			}
		}
		// Handle other errors
		return 0, err
	}
	return userID, nil
}

func (u *UserRepository) GetUserByEmail(email string) (*model.User, error) {
	//check the if the email is in the database
	query := `SELECT id, name, email, hashed_password FROM users WHERE email = $1`
	stmt, err := u.db.Prepare(query)
	if err != nil {
		return nil, fmt.Errorf("error preparing query")
	}
	defer stmt.Close()

	user := &model.User{}

	err = stmt.QueryRow(email).Scan(&user.ID, &user.Name, &user.Email, &user.HashedPassword)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, fmt.Errorf("user not found")
		}
		return nil, fmt.Errorf("error executing query: %v", err)
	}

	return user, nil
}

func (u *UserRepository) GetUserById(userId int) (*model.User, error) {
	query := `SELECT id, name, email FROM users WHERE id = $1`
	stmt, err := u.db.Prepare(query)
	if err != nil {
		return nil, fmt.Errorf("error preparing query: %v", err)
	}
	defer stmt.Close()

	user := &model.User{}
	err = stmt.QueryRow(userId).Scan(&user.ID, &user.Name, &user.Email)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, fmt.Errorf("user not found: %v", err)
		}
		return nil, fmt.Errorf("error executing query %v", err)
	}

	return user, nil
}
