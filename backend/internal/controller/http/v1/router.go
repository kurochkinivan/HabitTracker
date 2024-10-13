package v1

import (
	"fmt"
	"net/http"

	"github.com/kurochkinivan/HabitTracker/internal/usecase"
	httpSwagger "github.com/swaggo/http-swagger"
)

type Handler interface {
	Register(mux *http.ServeMux)
}

type Handlers struct {
	Auth authHandler
}

func NewHandlers(auth authHandler) *Handlers {
	return &Handlers{
		Auth: auth,
	}
}

// @title			Habit Tracker API
// @description		habit tracker API for mobile app
// @version			1.0.0
// @host			localhost:8080
// @BasePath		/v1
func NewRouter(host, port string, bytesLimit int64, a usecase.Auth) error {
	mux := http.NewServeMux()

	authHandler := NewAuthHandler(a, bytesLimit)
	authHandler.Register(mux)

	httpSwagger.Handler()
	mux.Handle("/swagger/", httpSwagger.WrapHandler)

	return http.ListenAndServe(fmt.Sprintf("%s:%s", host, port), mux)
}
