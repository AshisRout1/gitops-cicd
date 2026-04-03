# Use minimal and updated base image
FROM python:3.9-slim-bullseye

# Prevent Python from writing pyc files & enable logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system updates (VERY IMPORTANT for Trivy)
RUN apt-get update && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency file first (better caching)
COPY requirements.txt .

# Upgrade pip & install dependencies securely
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create non-root user (security best practice)
RUN useradd -m appuser
USER appuser

# Expose port
EXPOSE 8000

# Run application
CMD ["python", "main.py"]
