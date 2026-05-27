.PHONY: help install build up down logs test lint format clean

help:
	@echo "SOC Platform Integrated - Available Commands"
	@echo "============================================"
	@echo "make install        - Install dependencies"
	@echo "make build          - Build Docker images"
	@echo "make up             - Start all services"
	@echo "make down           - Stop all services"
	@echo "make logs           - View service logs"
	@echo "make test           - Run tests"
	@echo "make lint           - Run linters"
	@echo "make format         - Format code"
	@echo "make clean          - Clean build artifacts"
	@echo "make dev            - Start development environment"
	@echo "make coverage       - Generate test coverage report"

install:
	@echo "Installing dependencies..."
	pip install -r requirements.txt
	npm install

build:
	@echo "Building Docker images..."
	docker-compose build

up:
	@echo "Starting services..."
	docker-compose up -d
	@echo "Services started! Access points:"
	@echo "  Dashboard:     http://localhost:5601"
	@echo "  Wazuh:         https://localhost:443"
	@echo "  API:           http://localhost:8000"

down:
	@echo "Stopping services..."
	docker-compose down

logs:
	docker-compose logs -f

logs-api:
	docker-compose logs -f api

logs-wazuh:
	docker-compose logs -f wazuh-manager

test:
	@echo "Running tests..."
	pytest tests/ -v

test-coverage:
	@echo "Generating coverage report..."
	pytest tests/ --cov=. --cov-report=html
	@echo "Coverage report generated in htmlcov/index.html"

lint:
	@echo "Running linters..."
	flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
	pylint **/*.py || true

format:
	@echo "Formatting code..."
	black . --line-length=100
	isort . --profile=black

dev:
	@echo "Starting development environment..."
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d
	@echo "Dev environment running with debug logging enabled"

clean:
	@echo "Cleaning build artifacts..."
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	rm -rf dist/ build/ *.egg-info/
	docker-compose down -v

restart:
	@echo "Restarting services..."
	docker-compose restart

ps:
	docker-compose ps

validate:
	@echo "Validating configuration..."
	docker-compose config
	@echo "Configuration is valid"