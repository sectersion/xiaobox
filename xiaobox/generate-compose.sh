#!/bin/bash

# XIAOBOX Docker Compose Generator
# Wrapper script for generate-compose.py

set -e

echo "XIAOBOX Configuration System"
echo "============================"

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed."
    echo "Please install Python 3 and try again."
    exit 1
fi

# Check if PyYAML is available
python3 -c "import yaml" 2>/dev/null || {
    echo "❌ PyYAML is required but not installed."
    echo "Install with: pip install PyYAML"
    exit 1
}

# Run the Python generator
echo "📝 Generating docker-compose.yml from config.yml..."
python3 generate-compose.py

echo ""
echo "✅ Configuration applied successfully!"
echo ""
echo "To start your services with the new configuration:"
echo "  cd docker"
echo "  docker-compose down  # Stop current services"
echo "  docker-compose up -d # Start with new config"
echo ""
echo "To view available services:"
echo "  docker-compose ps"