FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy source code
COPY mnemosyne/ ./mnemosyne/
COPY tests/ ./tests/
COPY pyproject.toml ./

# Install package with dev dependencies
RUN pip install --no-cache-dir -e ".[dev]"

# Default command runs tests
CMD ["pytest", "-v"]
