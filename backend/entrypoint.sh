#!/bin/bash
set -e

# Wait for database to be ready
echo "Waiting for database to be ready..."
while ! pg_isready -h db -p 5432 -U postgres; do
  sleep 1
done

# Run migrations
echo "Database is ready, running migrations..."
bin/erp eval "Erp.Release.migrate"

# Start the application
echo "Starting application..."
exec bin/erp start
