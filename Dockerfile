# 1. Build stage
FROM python:3.12-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --prefix=/install -r requirements.txt

COPY . .


# 2. Final stage (DISTROLESS)
FROM gcr.io/distroless/python3-debian12

WORKDIR /app

# Copy dependencies and app
COPY --from=builder /install /usr/local
COPY --from=builder /app /app

# Non-root user
USER nonroot:nonroot

EXPOSE 8000

# ✅ IMPORTANT FIX HERE
CMD ["python3", "main.py"]
