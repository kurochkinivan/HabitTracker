package main

import (
	"fmt"
	"os"
	"path"
	"runtime"

	"github.com/kurochkinivan/HabitTracker/config"
	"github.com/kurochkinivan/HabitTracker/internal/app"
	"github.com/sirupsen/logrus"
)

const (
	envLocal = "local"
	envProd  = "prod"
)

func main() {
	cfg := config.MustLoad()
	setupLogger(cfg.Environment)

	logrus.WithField("env", cfg.Environment).Info("starting habit-tracker server")

	err := app.Run(cfg)
	if err != nil {
		logrus.WithError(err).Fatal("app.Run failed")
	}
}

func setupLogger(env string) {
	callerPrettifer := func(f *runtime.Frame) (string, string) {
		filename := path.Base(f.File)
		funcName := path.Base(f.Function)
		return fmt.Sprintf("%s()", funcName), fmt.Sprintf("%s:%d", filename, f.Line)
	}

	logrus.SetReportCaller(true)
	logrus.SetOutput(os.Stdout)

	switch env {
	case envLocal:
		logrus.SetFormatter(&logrus.TextFormatter{
			ForceColors:      true,
			TimestampFormat:  "2006-01-02 15:04:05",
			FullTimestamp:    true,
			CallerPrettyfier: callerPrettifer,
		})
		logrus.SetLevel(logrus.TraceLevel)
	case envProd:
		logrus.SetFormatter(&logrus.JSONFormatter{
			TimestampFormat:  "2006-01-02 15:04:05",
			CallerPrettyfier: callerPrettifer,
		})
		logrus.SetLevel(logrus.InfoLevel)
	default:
		logrus.Fatal("unknown environment")
	}
}
