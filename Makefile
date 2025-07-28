.PHONY: dev build clean install lint format tail-log

dev:
	@SHOREMAN_COLORS=always scripts/shoreman.sh | tee dev.log

build:
	@cd frontend && npm install && npm run build
	@cd backend && mkdir -p bin && go build -o bin/backend ./cmd

clean:
	@rm -rf dev.log
	@rm -rf backend/bin
	@rm -rf frontend/dist
	@rm -rf frontend/node_modules/

install:
	@cd frontend && npm install
	@cd backend && go mod tidy

lint:
	@cd frontend && npm run lint
	@cd backend && go vet ./...

format:
	@cd frontend && npm run format
	@cd backend && go fmt ./...

tail-log:
	@tail -n 100 dev.log | perl -pe 's/\e\[[0-9;]*m(?:\e\[K)?//g';
