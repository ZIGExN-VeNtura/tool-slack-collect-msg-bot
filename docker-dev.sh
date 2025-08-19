#!/bin/bash

# Docker Development Helper Script for slackCollectMsg

case "$1" in
  "setup")
    echo "🚀 Setting up development environment with Docker..."
    docker compose build
    docker compose up -d db
    echo "⏳ Waiting for MySQL to be ready..."
    sleep 10
    docker compose run --rm web bundle exec rails db:create
    docker compose run --rm web bundle exec rails db:migrate
    echo "✅ Development environment is ready!"
    ;;
  
  "up")
    echo "🚀 Starting development environment..."
    docker compose up
    ;;
  
  "down")
    echo "🛑 Stopping development environment..."
    docker compose down
    ;;
  
  "logs")
    docker compose logs -f web
    ;;
  
  "rails")
    shift
    docker compose run --rm web bundle exec rails "$@"
    ;;
  
  "bash")
    docker compose run --rm web bash
    ;;
  
  "test")
    echo "🧪 Running tests..."
    docker compose run --rm -e RAILS_ENV=test -e TEST_DB_HOST=test_db -e DB_USER=root -e DB_PASSWORD= web bundle exec rails db:create
    docker compose run --rm -e RAILS_ENV=test -e TEST_DB_HOST=test_db -e DB_USER=root -e DB_PASSWORD= web bundle exec rails db:migrate
    docker compose run --rm -e RAILS_ENV=test -e TEST_DB_HOST=test_db -e DB_USER=root -e DB_PASSWORD= web bundle exec rails test
    ;;
  
  "clean")
    echo "🧹 Cleaning up Docker containers and volumes..."
    docker compose down -v
    docker system prune -f
    ;;
  
  *)
    echo "Usage: ./docker-dev.sh {setup|up|down|logs|rails|bash|test|clean}"
    echo ""
    echo "Commands:"
    echo "  setup  - Initial setup (build, create and migrate database)"
    echo "  up     - Start the development environment"
    echo "  down   - Stop the development environment"
    echo "  logs   - Show web container logs"
    echo "  rails  - Run rails commands (e.g., ./docker-dev.sh rails console)"
    echo "  bash   - Open bash shell in web container"
    echo "  test   - Run test suite"
    echo "  clean  - Clean up containers and volumes"
    ;;
esac