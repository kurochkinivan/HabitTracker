package v1

import (
	"net/http"

	"github.com/julienschmidt/httprouter"
	"github.com/kurochkinivan/HabitTracker/internal/usecase"
)

type habitHandler struct {
	h usecase.Habit
}

func NewHabitHandler(habit usecase.Habit) Handler {
	return &habitHandler{
		h: habit,
	}
}

func (h *habitHandler) Register(r *httprouter.Router) {
	r.GET("/v1/users/:id/habits", errMdw(logMdw(h.getHabits)))
}

func (h *habitHandler) getHabits(w http.ResponseWriter, r *http.Request, p httprouter.Params) error {
	w.Header().Set("Content-Type", "application/json")
	const op string = "habitHandler.getHabits"

	return nil
}
