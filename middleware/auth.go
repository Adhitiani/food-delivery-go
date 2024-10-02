package middleware

import (
	"context"
	"log"
	"net/http"
	"project/food-delivery/contextkeys"
	"project/food-delivery/service"
)

func AuthMiddleware(tokenService service.TokenServiceInterface, next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Printf("Incoming request for %s", r.URL.Path)

		// Skip access token validation for the refresh and logout route
		if r.URL.Path == "/api/user/refresh" || r.URL.Path == "/api/user/logout" {
			next.ServeHTTP(w, r)
			return
		}

		claims, err := tokenService.ValidateAccessToken(tokenService.GetTokenFromBearerString(r.Header.Get("Authorization")))
		if err != nil {
			http.Error(w, "Invalid credentials", http.StatusUnauthorized)
			return
		}

		ctx := context.WithValue(r.Context(), contextkeys.UserIDKey, claims.ID)
		log.Printf("Setting user ID in context: %v", claims.ID)
		r = r.WithContext(ctx)
		next.ServeHTTP(w, r)
	})
}
