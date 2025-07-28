# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Full-stack application with React/TypeScript frontend and Go backend. Uses Vite for frontend development and chi router for Go HTTP server. Development managed through Procfile using shoreman for process orchestration.

## Architecture

- **Frontend**: React 19 + TypeScript + Vite development setup in `frontend/`
- **Backend**: Go HTTP server using chi router in `backend/`
- **Process Management**: Procfile defines frontend/backend services, managed by shoreman script
- **Development Server**: Backend runs on port 8080, frontend on port 5173 via `make dev`
- **Auto-reload**: Both frontend and backend automatically reload on file changes

## Development Commands

- `make dev` - Starts development servers (backend on port 8080, frontend on port 5173). We rarely need this command
- `make build` - Build production application (frontend and backend binaries in bin/)
- `make install` - Install dependencies (npm install + go mod tidy)
- `make lint` - Run linters (eslint for frontend, go vet for backend)
- `make format` - Format frontend (Prettier) and backend (go fmt) code
- `make clean` - Clean build artifacts
- `make tail-log` - Reads the current log file (last 100 lines)

**IMPORTANT:** Use the `make tail-log` command to read the log file.
