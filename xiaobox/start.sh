#!/bin/bash

# XIAOBOX Start Script
# Starts all Docker containers for the XIAOBOX project

set -e

echo "Starting XIAOBOX Services..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Docker is not running. Please start Docker service first."
    echo "   sudo systemctl start docker"
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose is not installed."
    exit 1
fi

# Generate docker-compose.yml from config if script exists
if [[ -f "../generate-compose.py" ]]; then
    echo "Generating docker-compose.yml from config.yml..."
    cd ..
    python3 generate-compose.py 2>/dev/null || echo "⚠️  Config generation failed - using existing docker-compose.yml"
    cd docker
elif [[ -f "generate-compose.py" ]]; then
    echo "Generating docker-compose.yml from config.yml..."
    python3 generate-compose.py 2>/dev/null || echo "⚠️  Config generation failed - using existing docker-compose.yml"
else
    echo "Config generation script not found - using existing docker-compose.yml"
fi

# Navigate to docker directory
if [[ -d "docker" ]]; then
    cd docker
elif [[ -d "../docker" ]]; then
    cd ../docker
else
    echo "Docker directory not found. Please run this script from the xiaobox directory."
    exit 1
fi

# Start all services
echo "Starting all containers..."
docker-compose up -d

# Wait a moment for services to start
sleep 5

# Check status
echo "Service Status:"
docker-compose ps

echo ""
echo "XIAOBOX Services Started!"
echo ""
echo "Access your services:"
echo "   - Main site: http://localhost"
echo "   - Eaglercraft: http://localhost"
echo "   - VS Code Server: http://localhost:8082 (password: student)"
echo "   - TheLounge IRC: http://localhost:9000"
echo "   - Traefik Dashboard: http://localhost:8080"
echo ""
echo "To stop all services: docker-compose down"
echo "To view logs: docker-compose logs -f"
echo "To reconfigure: edit ../config.yml and run ../generate-compose.sh"