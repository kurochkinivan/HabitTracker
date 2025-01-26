package v1

import (
	"fmt"
	"net/http"

	"github.com/julienschmidt/httprouter"
	"github.com/kurochkinivan/HabitTracker/internal/usecase"
	httpSwagger "github.com/swaggo/http-swagger"
)

type Handler interface {
	Register(r *httprouter.Router)
}

type Handlers struct {
	Auth  authHandler
	Habit habitHandler
}

func NewHandlers(auth authHandler) *Handlers {
	return &Handlers{
		Auth: auth,
	}
}

// @title			Habit Tracker API
// @description	habit tracker API for mobile app
// @version		1.0
// @host			localhost:8080
// @BasePath		/v1
func NewRouter(host, port string, bytesLimit int64, sigingKey string, a usecase.Auth) error {
	r := httprouter.New()

	authHandler := NewAuthHandler(a, bytesLimit, sigingKey)
	authHandler.Register(r)

	httpSwagger.Handler()
	r.Handler(http.MethodGet, "/swagger/", httpSwagger.WrapHandler)

	return http.ListenAndServe(fmt.Sprintf("%s:%s", host, port), r)
}
