package response

type TokenResponse struct {
	AccessToken string `json:"access_token"`
}

type UserResponse struct {
	ID    int    `json:"id"`
	Name  string `json:"name"`
	Email string `json:"email"`
}
