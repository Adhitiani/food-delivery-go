package service

import (
	"errors"
	"log"
	"project/food-delivery/config"
	"strings"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

type JwtCustomClaims struct {
	ID int `json:"id"`
	jwt.RegisteredClaims
}

type TokenService struct {
	cfg *config.Config
}

func NewTokenService(cfg *config.Config) *TokenService {
	return &TokenService{
		cfg: cfg,
	}
}

func (s *TokenService) GenerateAccessToken(userID int) (string, error) {
	return s.generateToken(userID, s.cfg.AccessLifetimeMinutes, s.cfg.AccessSecret)
}

func (s *TokenService) GenerateRefreshToken(userID int) (string, error) {
	return s.generateToken(userID, s.cfg.RefreshLifetimeMinutes, s.cfg.RefreshSecret)
}

func (s *TokenService) generateToken(userID, lifetimeMinutes int, secret string) (string, error) {
	claims := &JwtCustomClaims{
		userID,
		jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(time.Minute * time.Duration(lifetimeMinutes))),
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	return token.SignedString([]byte(secret))
}

func (s *TokenService) ValidateAccessToken(tokenString string) (*JwtCustomClaims, error) {
	return s.validateToken(tokenString, s.cfg.AccessSecret)
}

func (s *TokenService) ValidateRefreshToken(tokenString string) (*JwtCustomClaims, error) {
	return s.validateToken(tokenString, s.cfg.RefreshSecret)
}

func (s *TokenService) validateToken(tokenString, secret string) (*JwtCustomClaims, error) {
	log.Println("Starting token validation for token:", tokenString)

	token, err := jwt.ParseWithClaims(tokenString, &JwtCustomClaims{}, func(token *jwt.Token) (interface{}, error) {
		log.Println("Token signing method:", token.Method.Alg())

		return []byte(secret), nil
	})
	if err != nil {
		return nil, err
	}

	claims, ok := token.Claims.(*JwtCustomClaims)
	if !ok || !token.Valid {
		return nil, errors.New("failed to parse token claims")
	}
	log.Println("Token validated for user ID:", claims.ID)
	return claims, nil
}

func (s *TokenService) GetTokenFromBearerString(bearerString string) string {
	if bearerString == "" {
		return ""
	}

	parts := strings.Split(bearerString, "Bearer")
	if len(parts) != 2 {
		return ""
	}

	token := strings.TrimSpace(parts[1])
	if len(token) < 1 {
		return ""
	}

	return token
}
