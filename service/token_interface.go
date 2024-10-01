package service

type TokenServiceInterface interface {
	GenerateAccessToken(userID int) (string, error)
	GenerateRefreshToken(userID int) (string, error)
	ValidateAccessToken(tokenString string) (*JwtCustomClaims, error)
	ValidateRefreshToken(tokenString string) (*JwtCustomClaims, error)
	GetTokenFromBearerString(bearerString string) string
}
