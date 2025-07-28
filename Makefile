SHELL := /bin/bash

.PHONY: dev build clean install test lint format tail-log check-deps
dev:
	@echo "Starting development servers (frontend on :5173, backend on :8080)..."
	@SHOREMAN_COLORS=always scripts/shoreman.sh 2>&1 | tee dev.log

build:
	@echo "Building frontend application..." && \
	cd frontend && npm run build && \
	echo "Building backend server..." && \
	cd ../backend && mkdir -p ../bin && go build -o ../bin/backend ./... && \
	echo "Build completed successfully - binaries available in bin/"

clean:
	@echo "Cleaning build artifacts and cache files..."
	@rm -f dev.log dev.log.new && \
	cd frontend && npm run clean 2>/dev/null || true && \
	rm -rf node_modules/.cache dist build .next out coverage && \
	cd ../backend && go clean && \
	echo "Clean completed"

install: check-deps
	@echo "Installing project dependencies..."
	@echo "Installing frontend dependencies..." && \
	cd frontend && npm install && \
	echo "Installing backend dependencies..." && \
	cd ../backend && go mod tidy && \
	echo "All dependencies installed successfully"

test:
	@echo "Running test suite for frontend and backend..."
	@echo "Running frontend tests..." && \
	cd frontend && npm test && \
	echo "Running backend tests..." && \
	cd ../backend && go test ./... && \
	echo "All tests completed"

lint:
	@echo "Running linting checks on frontend and backend code..."
	@echo "Linting frontend..." && \
	cd frontend && npx eslint . && \
	echo "Linting backend..." && \
	cd ../backend && go vet ./... && \
	echo "Linting completed successfully"

format:
	@echo "Formatting frontend and backend code..."
	@cd frontend && npx prettier --write . && \
	echo "Frontend formatting completed" && \
	cd ../backend && go fmt ./... && \
	echo "Backend formatting completed"

tail-log:
	@echo "Reading last 100 lines of development log..."
	@if [ -f dev.log ]; then tail -n 100 dev.log; else echo "No dev.log found - run 'make dev' first"; fi

check-deps:
	@echo "Checking required dependencies..."
	@command -v node >/dev/null 2>&1 || { echo "Error: Node.js is required but not installed"; exit 1; }
	@command -v go >/dev/null 2>&1 || { echo "Error: Go is required but not installed"; exit 1; }
	@echo "All required dependencies are installed"
