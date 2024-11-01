package v1

import (
	"errors"
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/go-chi/chi/v5/middleware"
	"github.com/golang-jwt/jwt/v5"
	apperr "github.com/kurochkinivan/HabitTracker/internal/appError"
	"github.com/sirupsen/logrus"
)

const (
	RequestIDKey = 0
)

type appHandler func(w http.ResponseWriter, r *http.Request) error

func logMdw(next appHandler) appHandler {
	return func(w http.ResponseWriter, r *http.Request) error {
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

func authMdw(next appHandler, signingKey string) appHandler {
	return func(w http.ResponseWriter, r *http.Request) error {
		header := r.Header.Get("Authorization")
		if header == "" {
			return apperr.ErrEmptyAuthHeader
		}

		headerParts := strings.Split(header, " ")
		if len(headerParts) != 2 {
			return apperr.ErrInvalidAuthHeader
		}

		payload, err := parseToken(signingKey, headerParts[1])
		if err != nil {
			return err
		}

		exp := time.Unix(int64(payload["exp"].(float64)), 0)
		if time.Now().After(exp) {
			return apperr.ErrTokenExired
		}

		r.Header.Set("user_id", payload["ueid"].(string))

		return next(w, r)
	}
}

func errMdw(h appHandler) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var appErr *apperr.AppError
		err := h(w, r)

		if err != nil {
			if errors.As(err, &appErr) {
				w.WriteHeader(appErr.HTTPCode)
				w.Write(appErr.MarshalWithTrace(err.Error()))
				return
			}

			w.WriteHeader(http.StatusInternalServerError)
			w.Write(apperr.SystemError(err, "appHandler.errMdw", "not custom error").MarshalWithTrace(err.Error()))
		}
	}
}

func parseToken(signingKey, accessToken string) (jwt.MapClaims, error) {
	logrus.WithField("token", accessToken).Debug("parsing jwt-token")
	const op string = "middleware.ParseToken"

	token, err := jwt.Parse(accessToken, func(t *jwt.Token) (interface{}, error) {
		if _, ok := t.Method.(*jwt.SigningMethodHMAC); !ok {
			logrus.WithField("alg", t.Header["alg"]).Error("unexpected signing method")
			return nil, apperr.SystemError(nil, op, "unexpected signing method")
		}
		return []byte(signingKey), nil
	})

	if err != nil {
		if errors.Is(err, jwt.ErrTokenExpired) {
			return nil, apperr.ErrTokenExired
		}
		return nil, apperr.ErrInvalidAuthHeader.WithErr(fmt.Errorf("%s: %w", op, err))
	}

	payload, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		return nil, apperr.SystemError(nil, op, "claims are not of type jwt.MapClaims")
	}

	return payload, nil
}
