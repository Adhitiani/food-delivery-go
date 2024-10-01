package service

import (
	"errors"
)

type MockTokenService struct {
	ValidToken bool
	UserID     int // Add this field to simulate user ID retrieval
}

func (m *MockTokenService) ValidateToken(token string) (int, bool) {
	if m.ValidToken {
		return m.UserID, true // Return the mock user ID and valid status
	}
	return 0, false // Return 0 and false if the token is invalid
}

func (m *MockTokenService) GenerateAccessToken(userID int) (string, error) {
	return "mockAccessToken", nil
}

func (m *MockTokenService) GenerateRefreshToken(userID int) (string, error) {
	return "mockRefreshToken", nil
}

func (m *MockTokenService) ValidateAccessToken(tokenString string) (*JwtCustomClaims, error) {
	if m.ValidToken {
		return &JwtCustomClaims{ID: 1}, nil
	}
	return nil, errors.New("invalid token")
}

func (m *MockTokenService) ValidateRefreshToken(tokenString string) (*JwtCustomClaims, error) {
	if m.ValidToken {
		return &JwtCustomClaims{ID: 1}, nil
	}
	return nil, errors.New("invalid token")
}

func (m *MockTokenService) GetTokenFromBearerString(bearerString string) string {
	if bearerString == "" {
		return ""
	}
	if len(bearerString) < 7 || bearerString[:7] != "Bearer " {
		return ""
	}
	return bearerString[7:]
}
