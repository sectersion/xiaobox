# Use the official Nginx Proxy Manager image as a base
FROM jc21/nginx-proxy-manager:latest

# Set workdir
WORKDIR /app

# Create mount points inside the container
VOLUME ["/data", "/etc/letsencrypt"]

# Expose the needed ports
EXPOSE 80 81 443
