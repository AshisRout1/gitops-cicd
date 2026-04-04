# 1. Build stage
FROM python:3.12-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --prefix=/install -r requirements.txt

COPY . .

# 2. Final stage
FROM gcr.io/distroless/python3-debian12

WORKDIR /app

COPY --from=builder /install /usr/local
COPY --from=builder /app /app

USER nonroot:nonroot

EXPOSE 8000

# ✅ FIX
CMD ["python3", "main.py"]
