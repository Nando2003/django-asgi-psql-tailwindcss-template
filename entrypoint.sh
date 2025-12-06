#!/bin/sh
set -e
UV_RUN="uv run --no-sync"

while ! nc -z "$POSTGRES_HOST" "$POSTGRES_PORT"; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

mkdir -p /app/staticfiles

$UV_RUN manage.py makemigrations --noinput
$UV_RUN manage.py migrate --noinput
$UV_RUN manage.py collectstatic --noinput

echo "Production server starting..."
exec $UV_RUN daphne -b 0.0.0.0 -p 8000 core.asgi:application