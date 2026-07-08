.PHONY: help install test test-integration lint format check clean

help:           ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install:        ## Install dependencies
	pip install -e ".[dev]"

test:           ## Run unit tests (no PostgreSQL required)
	pytest tests/ -v -m "not integration"

test-integration: ## Run integration tests (requires PostgreSQL)
	pytest tests/ -v -m integration

lint:           ## Run linting
	flake8 mnemosyne/ tests/
	mypy mnemosyne/

format:         ## Format code
	black mnemosyne/ tests/

check:          ## Run all checks (test + lint)
	make test
	make lint

clean:          ## Clean build artifacts
	rm -rf build/ dist/ *.egg-info .pytest_cache .mypy_cache htmlcov/
