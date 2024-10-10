package v1

import (
	"errors"
	"net/http"
	"time"

	"github.com/go-chi/chi/v5/middleware"
	apperr "github.com/kurochkinivan/HabitTracker/internal/appError"
	"github.com/sirupsen/logrus"
)

const (
	RequestIDKey = 0
)

type appHandler func(w http.ResponseWriter, r *http.Request) error

func logMdw(next appHandler) appHandler {
	return func(w http.ResponseWriter, r *http.Request) error {

		logrus.Info("logger middleware enabled")
		entry := logrus.WithFields(logrus.Fields{
			"method":      r.Method,
			"path":        r.URL.Path,
			"remote_addr": r.RemoteAddr,
			"user_agent":  r.UserAgent(),
			"request_id":  middleware.GetReqID(r.Context()),
		})

		ww := middleware.NewWrapResponseWriter(w, r.ProtoMajor)
		t := time.Now()

		defer func() {
			entry.WithFields(logrus.Fields{
				"status":   ww.Status(),
				"size":     ww.BytesWritten(),
				"duration": time.Since(t),
			}).Info("request completed")
		}()

		return next(ww, r)
	}
}

func errMdw(h appHandler) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		logrus.Info("error middleware enabled")

		var appErr *apperr.AppError
		err := h(w, r)

		if err != nil {
			if errors.As(err, &appErr) {
				w.WriteHeader(appErr.HttpCode)
				w.Write(appErr.Marshal())
				return
			}

			w.WriteHeader(http.StatusInternalServerError)
			w.Write(apperr.SystemError(err, "error", "not custom error").Marshal())
		}
	}
}
