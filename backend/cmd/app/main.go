package main

import (
	"fmt"
	"html/template"
	"os"
	"path"
	"runtime"

	"github.com/kurochkinivan/HabitTracker/config"
	_ "github.com/kurochkinivan/HabitTracker/docs"
	"github.com/kurochkinivan/HabitTracker/internal/app"
	"github.com/sirupsen/logrus"
)

const (
	envLocal               = "local"
	envProd                = "prod"
	pathToConfirmLocal     = "../../static/html/confirmation_email.html"
	pathToEmailExistsLocal = "../../static/html/email_already_exists.html"
	pathToConfirmProd      = "confirmation_email.html"
	pathToEmailExistsProd  = "email_already_exists.html"
)

func main() {
	logrus.Info("starting app...")

	logrus.Info("reading config...")
	cfg := config.MustLoad()

	logrus.Info("setting up logger...")
	setupLogger(cfg.Environment)

	logrus.Info("initializing email templates...")
	tmpls := initEmails(cfg.Environment)

	logrus.WithField("env", cfg.Environment).Info("starting habit-tracker server")
	err := app.Run(cfg, tmpls)
	if err != nil {
		logrus.WithError(err).Fatal("app.Run failed")
	}
}

func setupLogger(env string) {
	callerPrettyfier := func(f *runtime.Frame) (string, string) {
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
			CallerPrettyfier: callerPrettyfier,
		})
		logrus.SetLevel(logrus.TraceLevel)
	case envProd:
		logrus.SetFormatter(&logrus.JSONFormatter{
			TimestampFormat:  "2006-01-02 15:04:05",
			CallerPrettyfier: callerPrettyfier,
		})
		logrus.SetLevel(logrus.InfoLevel)
	default:
		logrus.Fatal("unknown environment")
	}
}

func initEmails(env string) map[string]*template.Template {
	pathToConfirm, pathToEmailExists := getTemplatesPaths(env)
	tmpls := make(map[string]*template.Template)
	tmpls["confirm"] = template.Must(template.ParseFiles(pathToConfirm))
	tmpls["email_exists"] = template.Must(template.ParseFiles(pathToEmailExists))

	return tmpls
}

func getTemplatesPaths(env string) (confirm string, emailExists string) {
	switch env {
	case envLocal:
		return pathToConfirmLocal, pathToEmailExistsLocal
	case envProd:
		return pathToEmailExistsLocal, pathToEmailExistsProd
	default:
		logrus.Fatal("unknown environment")
		return "", ""
	}
}
