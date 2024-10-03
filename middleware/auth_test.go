package middleware

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"project/food-delivery/contextkeys"
	"project/food-delivery/service"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/suite"
)

type AuthMiddlewareTestSuite struct {
	suite.Suite
	tokenService service.TokenServiceInterface
}

func (suite *AuthMiddlewareTestSuite) SetupTest() {
	suite.tokenService = &service.MockTokenService{}
}

func (suite *AuthMiddlewareTestSuite) TestAuthMiddleware() {
	testCases := []struct {
		name               string
		bearerString       string
		validToken         bool
		expectedStatusCode int
		expectedUserID     int
	}{
		{
			name:               "Valid token",
			bearerString:       "Bearer valid_token",
			validToken:         true,
			expectedStatusCode: http.StatusOK,
			expectedUserID:     1,
		},
		{
			name:               "Invalid token",
			bearerString:       "Bearer invalid_token",
			validToken:         false,
			expectedStatusCode: http.StatusUnauthorized,
			expectedUserID:     0,
		},
		{
			name:               "Refresh route",
			bearerString:       "Bearer valid_token",
			validToken:         true,
			expectedStatusCode: http.StatusOK,
			expectedUserID:     0,
		},
		{
			name:               "Logout route",
			bearerString:       "Bearer valid_token",
			validToken:         true,
			expectedStatusCode: http.StatusOK,
			expectedUserID:     0,
		},
	}

	for _, testCase := range testCases {
		suite.T().Run(testCase.name, func(t *testing.T) {
			mockTokenService := suite.tokenService.(*service.MockTokenService)
			if testCase.validToken {
				mockTokenService.ValidToken = true
				mockTokenService.UserID = 1
			} else {
				mockTokenService.ValidToken = false
			}

			req, _ := http.NewRequest("GET", "/api/user/any", nil)
			req.Header.Set("Authorization", testCase.bearerString)

			rr := httptest.NewRecorder()

			nextHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {

				if r.URL.Path == "/api/user/refresh" || r.URL.Path == "/api/user/logout" {
					assert.Equal(t, testCase.expectedUserID, 0)
				} else {
					if userID, ok := r.Context().Value(contextkeys.UserIDKey).(int); ok {
						assert.Equal(t, testCase.expectedUserID, userID)
					}
				}
				w.WriteHeader(http.StatusOK)
			})

			handler := AuthMiddleware(mockTokenService, nextHandler)
			handler.ServeHTTP(rr, req)

			assert.Equal(t, testCase.expectedStatusCode, rr.Code)
		})
	}
}
func TestAuthMiddlewareSuite(t *testing.T) {
	suite.Run(t, new(AuthMiddlewareTestSuite))
}
