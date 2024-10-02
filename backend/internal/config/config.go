package config

import (
	"os"
	"time"

	"github.com/ilyakaznacheev/cleanenv"
	"github.com/sirupsen/logrus"
)

type Config struct {
	Environment string `yaml:"environment" env:"ENVIRONMENT"`

	HTTP struct {
		Host         string        `yaml:"host" env:"HTTP_HOST"`
		Port         string        `yaml:"port" env:"HTTP_PORT"`
		ReadTimeout  time.Duration `yaml:"read_timeout" env:"HTTP_READ_TIMEOUT"`
		WriteTimeout time.Duration `yaml:"write_timeout" env:"HTTP_WRITE_TIMEOUT"`
		IdleTimeout  time.Duration `yaml:"idle_timeout" env:"HTTP_IDLE_TIMEOUT"`
	} `yaml:"http"`

	PostgreSQL struct {
		Host     string `yaml:"host" env:"PSQL_HOST"`
		Port     string `yaml:"port" env:"PSQL_PORT"`
		Username string `yaml:"username" env:"PSQL_USERNAME"`
		Password string `yaml:"password" env:"PSQL_PASSWORD"`
		Database string `yaml:"database" env:"PSQL_DATABASE"`
	} `yaml:"postgresql"`
}

func MustLoad() *Config {
	configPath := os.Getenv("CONFIG_PATH")
	if configPath == "" {
		logrus.Warn("CONFIG_PATH is not set")
		configPath = "config.yaml"
		// configPath = "../../config/config.yaml"
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
