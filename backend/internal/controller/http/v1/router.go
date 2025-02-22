package v1

import (
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

func NewHandlers(auth authHandler, habit habitHandler) *Handlers {
	return &Handlers{
		Auth:  auth,
		Habit: habit,
	}
}

// @title			Habit Tracker API
// @description	habit tracker API for mobile app
// @version		1.0
// @host			localhost:8080
// @BasePath		/v1
func NewRouter(bytesLimit int64, sigingKey string, usecases *usecase.UseCases) http.Handler {
	r := httprouter.New()

	authHandler := NewAuthHandler(usecases.AuthUseCase, bytesLimit, sigingKey)
	authHandler.Register(r)

	habitHandler := NewHabitHandler(usecases.HabitUseCase, bytesLimit, sigingKey)
	habitHandler.Register(r)

	r.Handler(http.MethodGet, "/swagger/*filepath", httpSwagger.WrapHandler)

	return r
}
