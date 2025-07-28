dev:
	@SHOREMAN_COLORS=always scripts/shoreman.sh 2>&1 | tee dev.log

build:
	cd frontend && npm run build && \
	cd ../backend && mkdir -p ../bin && go build -o ../bin/backend ./cmd

clean:
	@rm -f dev.log dev.log.new && \
	cd frontend && npm run clean 2>/dev/null || true && \
	rm -rf node_modules/.cache dist build .next out coverage && \
	cd ../backend && go clean

install: check-deps
	cd frontend && npm install && \
	cd ../backend && go mod tidy

test:
	cd frontend && npm test && \
	cd ../backend && go test ./...

lint:
	cd frontend && npx eslint . && \
	cd ../backend && go vet ./...

format:
	@cd frontend && npx prettier --write . && \
	cd ../backend && go fmt ./...

tail-log:
	@if [ -f dev.log ]; then tail -n 100 dev.log; else echo "No dev.log found - run 'make dev' first"; fi

check-deps:
	@command -v node >/dev/null 2>&1 || { echo "Error: Node.js is required but not installed"; exit 1; }
	@command -v go >/dev/null 2>&1 || { echo "Error: Go is required but not installed"; exit 1; }
