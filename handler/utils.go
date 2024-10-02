package handler

import (
	"net/http"
)

// NotFoundHandler handles 404 responses
func NotFoundHandler(w http.ResponseWriter, r *http.Request) {
	http.Error(w, "404 Not Found", http.StatusNotFound)
}
