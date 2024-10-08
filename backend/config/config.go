package config

import (
	"os"
	"time"

	"github.com/ilyakaznacheev/cleanenv"
	"github.com/sirupsen/logrus"
)

type Config struct {
	Environment string `yaml:"environment" env:"ENVIRONMENT" env-required:"true"`

	JWT struct {
		TokenTTL time.Duration `yaml:"token_ttl" env:"JWT_TOKEN_TTL" env-required:"true"`
		JWTSignKey string `yaml:"jwt_sign_key" env:"JWT_SIGN_KEY" env-required:"true"`
	} `yaml:"jwt"`

	Hasher struct {
		HasherSalt string `yaml:"hasher_salt" env:"HASHER_SALT" env-required:"true"`
	} `yaml:"hasher"`

	HTTP struct {
		Host         string        `yaml:"host" env:"HTTP_HOST" env-required:"true"`
		Port         string        `yaml:"port" env:"HTTP_PORT" env-required:"true"`
		ReadTimeout  time.Duration `yaml:"read_timeout" env:"HTTP_READ_TIMEOUT" env-required:"true"`
		WriteTimeout time.Duration `yaml:"write_timeout" env:"HTTP_WRITE_TIMEOUT" env-required:"true"`
		IdleTimeout  time.Duration `yaml:"idle_timeout" env:"HTTP_IDLE_TIMEOUT" env-required:"true"`
	} `yaml:"http"`

	PostgreSQL struct {
		Host     string `yaml:"host" env:"PSQL_HOST" env-required:"true"`
		Port     string `yaml:"port" env:"PSQL_PORT" env-required:"true"`
		Username string `yaml:"username" env:"PSQL_USERNAME" env-required:"true"`
		Password string `yaml:"password" env:"PSQL_PASSWORD" env-required:"true"`
		Database string `yaml:"database" env:"PSQL_DATABASE" env-required:"true"`
	} `yaml:"postgresql"`
}

func MustLoad() *Config {
	configPath := os.Getenv("CONFIG_PATH")
	if configPath == "" {
		logrus.Warn("CONFIG_PATH is not set")
		// configPath = "config.yaml"
		configPath = "../../config/config.yaml"
	}

	if _, err := os.Stat(configPath); os.IsNotExist(err) {
		logrus.WithError(err).Fatalf("CONFIG_PATH does not exist")
	}

	cfg := &Config{}
	if err := cleanenv.ReadConfig(configPath, cfg); err != nil {
		logrus.WithError(err).Fatalf("Failed to read config")
	}

	return cfg
}
