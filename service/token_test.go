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
