package util

import (
	"crypto/tls"
	"net/http"
	"time"
)

// Create an HTTP client that skips SSL verification
func CreateInsecureClient() *http.Client {
	return &http.Client{
		Transport: &http.Transport{
			TLSClientConfig: &tls.Config{
				InsecureSkipVerify: true,
			},
			MaxIdleConnsPerHost: 10, // Reuse connections
			IdleConnTimeout:     90 * time.Second,
		},
		Timeout: 30 * time.Second, // Add a timeout to prevent hanging requests
	}
}

// Middleware to handle CORS
func CorsMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "http://localhost:5173")
		w.Header().Set("Access-Control-Allow-Credentials", "true")
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

		// Handle preflight requests
		if r.Method == http.MethodOptions {
			w.WriteHeader(http.StatusNoContent) // Respond with 204 No Content
			return
		}

		next.ServeHTTP(w, r)
	})
}
