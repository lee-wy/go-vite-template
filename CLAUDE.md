# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Full-stack application with React/TypeScript frontend and Go backend. Uses Vite for frontend development and chi router for Go HTTP server.

## Architecture

- **Frontend**: React 19 + TypeScript + Vite development setup in `frontend/`
- **Backend**: Go HTTP server using chi router in `backend/`
- **Process Management**: Procfile defines frontend/backend services, managed by shoreman script
- **Development Server**: Backend runs on port 8080, frontend on port 5173 via `make dev`
- **Auto-reload**: Both frontend and backend automatically reload on file changes

## Development Commands

- `make dev` - Starts development servers (backend on port 8080, frontend on port 5173)
- `make build` - Build production application (frontend in frontend/dist/ and backend in backend/bin/)
- `make install` - Install dependencies (npm install + go mod tidy)
- `make lint` - Run linters (eslint for frontend, go vet for backend)
- `make format` - Format frontend (Prettier) and backend (go fmt) code
- `make clean` - Clean build artifacts
- `make test` - Run tests for both frontend (vitest) and backend (go test)
- `make tail-log` - Reads the current log file (last 100 lines)

**IMPORTANT:** Use the `make tail-log` command to read the log file.
