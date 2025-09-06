#!/bin/bash

# XIAOBOX Installation Script
# This script installs Docker, Docker Compose, and sets up the XIAOBOX project

set -e

echo "Starting XIAOBOX Installation..."

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (sudo)"
   exit 1
fi

# Update system
echo "Updating system packages..."
apt update && apt upgrade -y

# Install required packages
echo "Installing required packages..."
apt install -y curl wget git unzip

# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh

# Install Docker Compose
echo "Installing Docker Compose..."
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Start and enable Docker service
systemctl start docker
systemctl enable docker

# Add current user to docker group (if not root)
if [[ $SUDO_USER ]]; then
    usermod -aG docker $SUDO_USER
    echo "Added $SUDO_USER to docker group"
fi

# Create installation directory
INSTALL_DIR="/opt/xiaobox"
echo "Creating installation directory: $INSTALL_DIR"
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# Copy project files (assuming this script is run from the project directory)
if [[ -f "../docker-compose.yml" ]]; then
    echo "Copying project files..."
    cp -r ../* ./
else
    echo "Error: Project files not found. Please run this script from the xiaobox directory."
    exit 1
fi

# Create necessary directories
echo "Creating data directories..."
cd docker
mkdir -p server/mc server/bungee server/irc webxash

# Set permissions
echo "Setting permissions..."
chown -R $SUDO_USER:$SUDO_USER ../

echo "Installation completed!"
echo ""
echo "Next steps:"
echo "1. Log out and back in (or run 'newgrp docker') to use Docker without sudo"
echo "2. Run './start.sh' to start all services"
echo "3. Access your services:"
echo "   - Main site: http://your-server-ip"
echo "   - TheLounge IRC: http://your-server-ip:9000"
echo "   - WebXash games: http://your-server-ip/webxash"
echo ""
echo "Don't forget to add your game files to docker/webxash/ for WebXash!"