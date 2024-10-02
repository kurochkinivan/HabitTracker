package main

import (
	"fmt"
	"net/http"
	"os"
	"path"
	"runtime"

	"github.com/kurochkinivan/HabitTracker/internal/app"
	"github.com/kurochkinivan/HabitTracker/internal/config"
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

	logrus.Fatal(http.ListenAndServe(fmt.Sprintf("%s:%s", cfg.HTTP.Host, cfg.HTTP.Port), nil))
}

func setupLogger(env string) {
	callerPrettifer := func(f *runtime.Frame) (string, string) {
		filename := path.Base(f.File)
		return fmt.Sprintf("%s()", f.Function), fmt.Sprintf("%s:%d", filename, f.Line)
	}

	logrus.SetLevel(logrus.TraceLevel)
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
	case envProd:
		logrus.SetFormatter(&logrus.JSONFormatter{
			TimestampFormat:  "2006-01-02 15:04:05",
			CallerPrettyfier: callerPrettifer,
		})
	default:
		logrus.Fatal("unknown environment")
	}
}
