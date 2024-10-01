package middleware

import (
	"context"
	"log"
	"net/http"
	"project/food-delivery/contextkeys"
	"project/food-delivery/service"
)

func AuthMiddleware(tokenService *service.TokenService, next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Printf("Incoming request for %s", r.URL.Path)

		// Skip access token validation for the refresh route
		if r.URL.Path == "/api/user/refresh" {
			next.ServeHTTP(w, r)
			return
		}

		claims, err := tokenService.ValidateAccessToken(tokenService.GetTokenFromBearerString(r.Header.Get("Authorization")))
		if err != nil {
			http.Error(w, "Invalid credentials", http.StatusUnauthorized)
			return
		}

		// Assuming claims.ID is an int; if not, convert as needed
		ctx := context.WithValue(r.Context(), contextkeys.UserIDKey, claims.ID)
		log.Printf("Setting user ID in context: %v", claims.ID)
		r = r.WithContext(ctx)
		next.ServeHTTP(w, r)
	})
}
