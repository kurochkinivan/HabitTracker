package middleware

import "net/http"

type appHandler func(w http.ResponseWriter, r *http.Request)  

func Logger(h appHandler) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		h(w, r)
	}
}