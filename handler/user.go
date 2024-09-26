package handler

import (
	"encoding/json"
	"log"
	"net/http"
	"project/food-delivery/config"
	"project/food-delivery/model"
	"project/food-delivery/request"
	"project/food-delivery/response"
	"project/food-delivery/service"
	"project/food-delivery/util/validator"
	"time"

	"golang.org/x/crypto/bcrypt"
)

type UserHandler struct {
	userService *service.UserService
	cfg         *config.Config
}

func NewUserHandler(userService *service.UserService, cfg *config.Config) *UserHandler {
	return &UserHandler{
		userService: userService,
		cfg:         cfg,
	}
}

func (h *UserHandler) InsertUserHandler() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var signupUser model.SignupUser

		//Parse the request body to the signupUser struct
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

		// Insert user to database, return the userId and handle errors
		userId, err := h.userService.InsertUser(signupUser)
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

		//Generate access and refresh tokens
		tokenService := service.NewTokenService(h.cfg)

		accessString, err := tokenService.GenerateAccessToken(userId)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		refreshString, err := tokenService.GenerateRefreshToken(userId)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// Set refresh token as httpOnly cookie
		http.SetCookie(w, &http.Cookie{
			Name:     "refresh_token",
			Value:    refreshString,
			Expires:  time.Now().Add(time.Duration(h.cfg.RefreshLifetimeMinutes) * time.Minute),
			HttpOnly: true,
			Path:     "/",
		})

		resp := response.LoginResponse{
			AccessToken: accessString,
		}

		w.WriteHeader(http.StatusCreated)
		json.NewEncoder(w).Encode(resp)
	}
}

func (h *UserHandler) LoginHandler() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		req := new(request.LoginRequest)
		if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}
		user, err := h.userService.GetUserByEmail(req.Email)
		if err != nil {
			http.Error(w, "Invalid credentials", http.StatusUnauthorized)
			return
		}

		if err = bcrypt.CompareHashAndPassword([]byte(user.HashedPassword), []byte(req.Password)); err != nil {
			http.Error(w, "Invalid credentials", http.StatusUnauthorized)
			return
		}

		tokenService := service.NewTokenService(h.cfg)

		accessString, err := tokenService.GenerateAccessToken(user.ID)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		refreshString, err := tokenService.GenerateRefreshToken((user.ID))
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		http.SetCookie(w, &http.Cookie{
			Name:     "refresh_token",
			Value:    refreshString,
			Expires:  time.Now().Add(time.Duration(h.cfg.RefreshLifetimeMinutes) * time.Minute),
			HttpOnly: true,
			Path:     "/",
		})

		resp := response.LoginResponse{
			AccessToken: accessString,
		}

		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(resp)
	}

}

func (h *UserHandler) GetProfile() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		tokenService := service.NewTokenService(h.cfg)
		claims, err := tokenService.ValidateAccessToken(tokenService.GetTokenFromBearerString(r.Header.Get("Authorization")))
		if err != nil {
			http.Error(w, "Invalid credentials", http.StatusUnauthorized)
			return
		}

		log.Printf("claims.ID, %v", claims.ID)

		user, err := h.userService.GetUserById(claims.ID)
		if err != nil {
			log.Printf("Error retrieving user: %v", err)
			http.Error(w, "User does not Exist", http.StatusBadRequest)
			return
		}

		resp := response.UserResponse{
			ID:    user.ID,
			Name:  user.Name,
			Email: user.Email,
		}

		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(resp)

	}

}
