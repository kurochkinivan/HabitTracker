package v1

import "net/http"

type Handler interface {
	Register(mux *http.ServeMux)
}
