package handler

import (
	"encoding/json"
	"log"
	"net/http"
	"project/food-delivery/model"
	"project/food-delivery/service"
	"project/food-delivery/util/validator"
)

func InsertUserHandler(userService *service.UserService) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var signupUser model.SignupUser

		//Parse the request body to the user struct
		err := json.NewDecoder(r.Body).Decode(&signupUser)
		if err != nil {
			log.Printf("Error decoding request body: %v", err)
			http.Error(w, "Invalid request payload", http.StatusBadRequest)
			return
		}

		// validate user data
		var validationErrors []model.ErrorResponseSignup
		if err := validator.NotBlank("Name", signupUser.Name); err != nil {
			validationErrors = append(validationErrors, model.ErrorResponseSignup{Field: "name", Message: err.Error()})
		} else if err := validator.ValidateName(signupUser.Name, 255, 5); err != nil {
			validationErrors = append(validationErrors, model.ErrorResponseSignup{Field: "name", Message: err.Error()})
		}

		if err := validator.ValidateEmail(signupUser.Email); err != nil {
			validationErrors = append(validationErrors, model.ErrorResponseSignup{Field: "email", Message: err.Error()})
		}
		if err := validator.ValidatePassword(signupUser.Password, 8); err != nil {
			validationErrors = append(validationErrors, model.ErrorResponseSignup{Field: "password", Message: err.Error()})
		}

		// If validation errors exist, return them as JSON
		if len(validationErrors) > 0 {
			w.Header().Set("Content-Type", "application/json")
			w.WriteHeader(http.StatusBadRequest)
			json.NewEncoder(w).Encode(validationErrors)
			return
		}

		// Insert user and handle errors
		err = userService.InsertUser(signupUser)
		if err != nil {
			if err.Error() == "email_already_exists" {
				w.Header().Set("Content-Type", "application/json")
				w.WriteHeader(http.StatusConflict) // 409 Conflict
				json.NewEncoder(w).Encode(model.ErrorResponseSignup{Field: "email", Message: "Email already registered"})
				return
			}

			log.Printf("Error inserting user: %v", err)
			http.Error(w, "Internal server error", http.StatusInternalServerError)
			return
		}
		log.Printf("User created succesfully")

		w.WriteHeader(http.StatusCreated) // 201 Created
	}
}
