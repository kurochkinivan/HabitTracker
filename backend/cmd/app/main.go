package main

import (
	"log"
	"log/slog"
	"os"
	"path/filepath"

	"github.com/kurochkinivan/HabitTracker/internal/config"
)

const (
	envLocal = "local"
	envProd  = "prod"
)

func main() {
	cfg := config.MustLoad()

	l := setupLogger(cfg.Environment)

	l.Info("starting habit-tracker server", slog.String("env", cfg.Environment))
}

func setupLogger(env string) *slog.Logger {
	var logger *slog.Logger

	replaceAttr := func(groups []string, a slog.Attr) slog.Attr {
		if a.Key == slog.SourceKey {
			s := a.Value.Any().(*slog.Source)
			dir, file := filepath.Split(s.File)
			s.File = filepath.Base(dir) + "/" + file
		}
		return a
	}

	switch env {
	case envLocal:
		logger = slog.New(
			slog.NewTextHandler(os.Stdout, &slog.HandlerOptions{
				Level:       slog.LevelDebug,
				AddSource:   true,
				ReplaceAttr: replaceAttr,
			}))
	case envProd:
		logger = slog.New(
			slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{
				Level:       slog.LevelInfo,
				AddSource:   true,
				ReplaceAttr: replaceAttr,
			}))
	default:
		log.Fatalf("unknown env: %s", env)
	}

	return logger
}
