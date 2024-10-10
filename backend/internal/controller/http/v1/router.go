package v1

import "net/http"

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

func NewRouter(handlers Handlers) *http.ServeMux {
	mux := http.NewServeMux()
	handlers.Auth.Register(mux)
	return mux
}