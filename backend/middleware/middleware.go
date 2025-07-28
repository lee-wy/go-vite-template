package middleware

import (
	"strings"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/go-chi/cors"
	"untitled/backend/config"
)

func SetupMiddleware(r *chi.Mux, cfg *config.Config) {
	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)

	// Configure CORS origins
	allowedOrigins := strings.Split(cfg.AllowedOrigins, ",")
	for i := range allowedOrigins {
		allowedOrigins[i] = strings.TrimSpace(allowedOrigins[i])
	}

	// Enable CORS for frontend
	r.Use(cors.Handler(cors.Options{
		AllowedOrigins:   allowedOrigins,
		AllowedMethods:   []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders:   []string{"Accept", "Authorization", "Content-Type", "X-CSRF-Token"},
		ExposedHeaders:   []string{"Link"},
		AllowCredentials: true,
		MaxAge:           300,
	}))

	if cfg.Environment == "production" {
		r.Use(middleware.Compress(5))
		r.Use(middleware.RealIP)
	}
}
