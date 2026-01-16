#!/bin/sh
set -e

echo "Fixing permissions..."
chown -R appuser:appgroup /app/staticfiles
chown -R appuser:appgroup /app/.cache

cd /app

echo "Waiting for PostgreSQL at ${POSTGRES_HOST}:${POSTGRES_PORT}..."
while ! nc -z "$POSTGRES_HOST" "$POSTGRES_PORT"; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done
echo "PostgreSQL is up."

echo "Running collectstatic..."
su-exec appuser:appgroup python manage.py collectstatic --noinput

echo "Running migrations..."
su-exec appuser:appgroup python manage.py migrate --noinput

echo "Starting Daphne..."
exec su-exec appuser:appgroup daphne -b 0.0.0.0 -p 8000 core.asgi:application