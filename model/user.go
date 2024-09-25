package model

type SignupUser struct {
	Name     string `json:"name"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

type User struct {
	ID             int    `json:"id"`
	Name           string `json:"name"`
	Email          string `json:"email"`
	HashedPassword []byte `json:"hashed_password"`
}

type ErrorResponseSignup struct {
	Field   string `json:"field"`
	Message string `json:"message"`
}
