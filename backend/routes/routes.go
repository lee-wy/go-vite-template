package routes

import (
	"go-vite-template/backend/handlers"

	"github.com/go-chi/chi/v5"
)

func SetupRoutes(r *chi.Mux) {
	r.Get("/", handlers.HomeHandler)
	r.Get("/health", handlers.HealthHandler)
}
