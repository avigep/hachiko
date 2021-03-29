#! /bin/sh

# Wait for DB services
sh ./config/docker/wait-for-services.sh

# Prepare DB (Migrate - If not? Create db & Migrate)
sh ./config/docker/prepare-db.sh

# Clean a stale pid file
rm -f tmp/pids/server.pid

# Start Application
bundle exec rails server -b 0.0.0.0

