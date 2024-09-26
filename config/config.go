package config

import (
	"log"
	"os"
	"strconv"

	"github.com/joho/godotenv"
)

type Config struct {
	Port                   string
	AccessSecret           string
	RefreshSecret          string
	AccessLifetimeMinutes  int
	RefreshLifetimeMinutes int
	DBHost                 string
	DBPort                 string
	DBUser                 string
	DBPassword             string
	DBName                 string
	DBMaxOpenConns         int
	DBMaxIdleConns         int
}

func NewConfig() *Config {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	accessMin, err := strconv.Atoi(os.Getenv("ACCESS_LIFETIME_MINUTES"))
	if err != nil {
		log.Fatal("Error importing .env file")
	}
	refreshMin, err := strconv.Atoi(os.Getenv("REFRESH_LIFETIME_MINUTES"))
	if err != nil {
		log.Fatal("Error importing .env file")
	}
	maxOpenConns, err := strconv.Atoi(os.Getenv("DB_MAX_OPEN_CONNS"))
	if err != nil {
		log.Fatal("Error parsing DB max open connections")
	}
	maxIdleConns, err := strconv.Atoi(os.Getenv("DB_MAX_IDLE_CONNS"))
	if err != nil {
		log.Fatal("Error parsing DB max idle connections")
	}

	return &Config{
		Port:                   os.Getenv("PORT"),
		AccessSecret:           os.Getenv("ACCESS_SECRET"),
		AccessLifetimeMinutes:  accessMin,
		RefreshSecret:          os.Getenv("REFRESH_SECRET"),
		RefreshLifetimeMinutes: refreshMin,
		DBHost:                 os.Getenv("DB_HOST"),
		DBPort:                 os.Getenv("DB_PORT"),
		DBUser:                 os.Getenv("DB_USER"),
		DBPassword:             os.Getenv("DB_PASSWORD"),
		DBName:                 os.Getenv("DB_NAME"),
		DBMaxOpenConns:         maxOpenConns,
		DBMaxIdleConns:         maxIdleConns,
	}
}

// DBConnStr returns the connection string for PostgreSQL
func (c *Config) DBConnStr() string {
	return "user=" + c.DBUser +
		" password=" + c.DBPassword +
		" dbname=" + c.DBName +
		" host=" + c.DBHost +
		" port=" + c.DBPort +
		" sslmode=disable"
}
