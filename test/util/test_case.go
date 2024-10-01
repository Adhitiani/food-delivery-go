package util

type TestCaseTokenFromBearer struct {
	Name         string
	BearerString string
	Want         string
}

type TestCaseValidateAccessToken struct {
	Name         string
	AccessToken  string
	WantError    bool
	WantErrorMsg string
	WantID       int
}
