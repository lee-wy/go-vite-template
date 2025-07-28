SHELL := /bin/bash

.PHONY: dev build clean install test lint format tail-log check-deps
dev:
	@echo "Starting dev servers..."
	@SHOREMAN_COLORS=always scripts/shoreman.sh 2>&1 | tee dev.log

build:
	@echo "Building..." && \
	cd frontend && npm run build && \
	echo "  Backend..." && \
	cd ../backend && mkdir -p ../bin && go build -o ../bin/backend ./...

clean:
	@echo "Cleaning..."
	@rm -f dev.log dev.log.new && \
	cd frontend && npm run clean 2>/dev/null || true && \
	rm -rf node_modules/.cache dist build .next out coverage && \
	cd ../backend && go clean

install: check-deps
	@echo "Installing dependencies..."
	@echo "  Frontend..." && \
	cd frontend && npm install && \
	echo "  Backend..." && \
	cd ../backend && go mod tidy

test:
	@echo "Running tests..."
	@echo "  Frontend..." && \
	cd frontend && npm test && \
	echo "  Backend..." && \
	cd ../backend && go test ./...

lint:
	@echo "Linting..."
	@echo "  Frontend..." && \
	cd frontend && npx eslint . && \
	echo "  Backend..." && \
	cd ../backend && go vet ./...

format:
	@echo "Formatting..."
	@cd frontend && npx prettier --write . && \
	echo "  Backend..." && \
	cd ../backend && go fmt ./...

tail-log:
	@echo "Reading last 100 lines of development log..."
	@if [ -f dev.log ]; then tail -n 100 dev.log; else echo "No dev.log found - run 'make dev' first"; fi

check-deps:
	@echo "Checking required dependencies..."
	@command -v node >/dev/null 2>&1 || { echo "Error: Node.js is required but not installed"; exit 1; }
	@command -v go >/dev/null 2>&1 || { echo "Error: Go is required but not installed"; exit 1; }
	@echo "All required dependencies are installed"
