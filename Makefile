SHELL := /bin/bash
export PATH := $(PATH):$(shell go env GOPATH)/bin

.PHONY: run db migrate stop

# Start postgres, apply migrations, then run the API on :8080
run: migrate
	set -a; . ./.env; set +a; go run ./cmd

db:
	docker-compose up -d --wait postgres

migrate: db
	set -a; . ./.env; set +a; goose up

stop:
	docker-compose down
