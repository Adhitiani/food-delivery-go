package validator

import (
	"errors"
	"regexp"
	"strconv"
	"strings"
)

func NotBlank(field, value string) error {
	if strings.TrimSpace(value) == "" {
		return errors.New(field + " is required")
	}
	return nil
}

// Regular expression for validating email addresses
var EmailRX = regexp.MustCompile("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")

func ValidateEmail(email string) error {
	if !EmailRX.MatchString(email) {
		return errors.New("invalid email format")
	}
	return nil
}

func ValidateName(name string, max int, min int) error {
	if len(name) > max || len(name) < min {
		return errors.New("Name must be between " + strconv.Itoa(min) + " and " + strconv.Itoa(max) + " characters long")
	}
	return nil
}

func MaxChars(field, value string, n int) error {
	if len(value) > n {
		return errors.New(field + "must be at least " + strconv.Itoa(n) + " characters long")
	}
	return nil
}

func MinChars(field, value string, n int) error {
	if len(value) < n {
		return errors.New(field + "must be at least " + strconv.Itoa(n) + " characters long")
	}
	return nil
}

func ValidatePassword(password string, n int) error {
	if len(password) < n {
		return errors.New("password must be at least " + strconv.Itoa(n) + " characters long")
	}
	return nil
}
