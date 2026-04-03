# 1. Build stage
FROM python:3.12-slim AS builder

WORKDIR /app

# Install only required packages
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --prefix=/install -r requirements.txt

# Copy app
COPY . .


# 2. Final stage (DISTROLESS)
FROM gcr.io/distroless/python3-debian12

WORKDIR /app

# Copy installed dependencies
COPY --from=builder /install /usr/local
COPY --from=builder /app /app

# Non-root user (VERY IMPORTANT)
USER nonroot:nonroot

EXPOSE 8000

CMD ["main.py"]
