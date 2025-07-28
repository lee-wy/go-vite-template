package routes

import (
	"github.com/go-chi/chi/v5"
	"untitled/backend/handlers"
)

func SetupRoutes(r *chi.Mux) {
	r.Get("/", handlers.HomeHandler)
	r.Get("/health", handlers.HealthHandler)
}