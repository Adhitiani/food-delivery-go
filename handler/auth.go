package handler

import (
	"encoding/json"
	"log"
	"net/http"
	"project/food-delivery/config"
	"project/food-delivery/response"
	"project/food-delivery/service"
	"time"
)

type AuthHandler struct {
	cfg *config.Config
}

func NewAuthHandler(cfg *config.Config) *AuthHandler {
	return &AuthHandler{
		cfg: cfg,
	}
}

func (h *AuthHandler) RefreshTokenHandler() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		cookie, err := r.Cookie("refresh_token")
		if err != nil {
			log.Println("Refresh token cookie not found")

			http.Error(w, "No Refresh Token", http.StatusUnauthorized)
			return
		}
		refreshToken := cookie.Value

		tokenService := service.NewTokenService(h.cfg)
		claims, err := tokenService.ValidateRefreshToken(refreshToken)
		if err != nil {
			http.Error(w, "Invalid or expired refresh token", http.StatusUnauthorized)
			return
		}

		newAccessToken, err := tokenService.GenerateAccessToken(claims.ID)
		if err != nil {
			http.Error(w, "Failed to generate access token", http.StatusInternalServerError)
			return
		}

		newRefreshToken, err := tokenService.GenerateRefreshToken(claims.ID)
		if err != nil {
			http.Error(w, "Failed to generate refresh token", http.StatusInternalServerError)
			return
		}

		http.SetCookie(w, &http.Cookie{
			Name:     "refresh_token",
			Value:    newRefreshToken,
			Expires:  time.Now().Add(time.Duration(h.cfg.RefreshLifetimeMinutes) * time.Minute),
			HttpOnly: true,
			Path:     "/",
			SameSite: http.SameSiteNoneMode,
			Secure:   false,
		})

		resp := response.TokenResponse{
			AccessToken: newAccessToken,
		}

		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(resp)
	}

}
