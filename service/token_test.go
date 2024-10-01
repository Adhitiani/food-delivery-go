package service

import (
	"project/food-delivery/config"
	"project/food-delivery/test/util"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/suite"
)

const userId = 1

type TokenServiceTestSuite struct {
	suite.Suite
	cfg          *config.Config
	tokenService *TokenService
}

func (suite *TokenServiceTestSuite) SetupSuite() {
	suite.cfg = &config.Config{
		Port:                   "",
		AccessSecret:           "accessSecret",
		RefreshSecret:          "resfreshSecret",
		AccessLifetimeMinutes:  2,
		RefreshLifetimeMinutes: 10,
	}
	suite.tokenService = NewTokenService(suite.cfg)
}

func (suite *TokenServiceTestSuite) SetupTest() {

}

func (suite *TokenServiceTestSuite) TearDownTest() {

}

func (suite *TokenServiceTestSuite) TearDownSuite() {

}

func TestTokenServiceSuite(t *testing.T) {
	suite.Run(t, new(TokenServiceTestSuite))
}

func (suite *TokenServiceTestSuite) TestGetTokenFromBearer() {
	testCases := []util.TestCaseTokenFromBearer{
		{
			Name:         "Get token from correct Bearer string",
			BearerString: "Bearer token_line",
			Want:         "token_line",
		}, {
			Name:         "Get token from incorrect Bearer string",
			BearerString: "Bearrr token_line",
			Want:         "",
		},
	}

	for _, testCase := range testCases {
		suite.T().Run(testCase.Name, func(t *testing.T) {

			got := suite.tokenService.GetTokenFromBearerString(testCase.BearerString)

			assert.Equal(t, testCase.Want, got)
		})

	}
}

// func (suite *TokenServiceTestSuite) TestValidateToken() {
// 	tokenString, _ := suite.tokenService.GenerateAccessToken(userId)
// 	refreshToken, _ := suite.tokenService.GenerateRefreshToken(userId)

// 	suite.cfg.AccessLifetimeMinutes = 0
// 	expiredTokenString, _ := suite.tokenService.GenerateAccessToken(userId)

// 	testCases := []util.TestCaseValidateAccessToken{
// 		{
// 			Name:         "Valid token",
// 			AccessToken:  tokenString,
// 			WantError:    false,
// 			WantErrorMsg: "",
// 			WantID:       userId,
// 		},
// 		{
// 			Name:         "Invalid token",
// 			AccessToken:  tokenString + " ",
// 			WantError:    true,
// 			WantErrorMsg: "token is malformed: could not base64 decode signature: illegal base64 data at input byte 43",
// 			WantID:       0,
// 		},
// 		{
// 			Name:         "Trying to use refresh token instead of access token",
// 			AccessToken:  refreshToken,
// 			WantError:    true,
// 			WantErrorMsg: "token signature is invalid: signature is invalid",
// 			WantID:       0,
// 		},
// 		{
// 			Name:         "Expired token",
// 			AccessToken:  expiredTokenString,
// 			WantError:    true,
// 			WantErrorMsg: "token has invalid claims: token is expired",
// 			WantID:       0,
// 		},
// 	}

// 	for _, testCase := range testCases {
// 		suite.T().Run(testCase.Name, func(t *testing.T) {
// 			gotClaims, gotErr := suite.tokenService.ValidateAccessToken(testCase.AccessToken)

// 			util.AssertTokenValidationResult(t, testCase, gotClaims, gotErr)
// 		})
// 	}

// }

func BenchmarkGenerateAccessToken(b *testing.B) {
	cfg := &config.Config{
		Port:                   "",
		AccessSecret:           "accessSecret",
		RefreshSecret:          "resfreshSecret",
		AccessLifetimeMinutes:  2,
		RefreshLifetimeMinutes: 10,
	}
	tokenService := NewTokenService(cfg)

	for i := 0; i < b.N; i++ {
		_, _ = tokenService.GenerateAccessToken(userId)
	}

}
