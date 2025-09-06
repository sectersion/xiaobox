#!/bin/bash

# XIAOBOX Eaglercraft Downloader
# Downloads Eaglercraft 1.12 WASM build and sets up local serving

set -e

echo "XIAOBOX Eaglercraft Downloader"
echo "=============================="

# Create directory for Eaglercraft files
EAGLECRAFT_DIR="public/eaglercraft-wasm"
mkdir -p "$EAGLECRAFT_DIR"

echo "Downloading Eaglercraft 1.12 WASM build..."

# Download the main HTML file
curl -L "https://git.zelz.net/Eagler-1.12/1.12-builds/src/branch/main/web/wasm/index.html" -o "$EAGLECRAFT_DIR/index.html"

# Download JavaScript files
curl -L "https://git.zelz.net/Eagler-1.12/1.12-builds/src/branch/main/web/wasm/eaglercraft.js" -o "$EAGLECRAFT_DIR/eaglercraft.js"
curl -L "https://git.zelz.net/Eagler-1.12/1.12-builds/src/branch/main/web/wasm/classes.js" -o "$EAGLECRAFT_DIR/classes.js"

# Download WASM file
curl -L "https://git.zelz.net/Eagler-1.12/1.12-builds/src/branch/main/web/wasm/eaglercraft.wasm" -o "$EAGLECRAFT_DIR/eaglercraft.wasm"

# Download CSS
curl -L "https://git.zelz.net/Eagler-1.12/1.12-builds/src/branch/main/web/wasm/main.css" -o "$EAGLECRAFT_DIR/main.css"

# Download assets (if they exist)
echo "Downloading assets..."
mkdir -p "$EAGLECRAFT_DIR/assets"

# Try to download common asset files
ASSETS=(
    "https://git.zelz.net/Eagler-1.12/1.12-builds/src/branch/main/web/wasm/assets/favicon.ico"
    "https://git.zelz.net/Eagler-1.12/1.12-builds/src/branch/main/web/wasm/assets/icon.png"
)

for asset in "${ASSETS[@]}"; do
    filename=$(basename "$asset")
    if curl -L "$asset" -o "$EAGLECRAFT_DIR/assets/$filename" 2>/dev/null; then
        echo "Downloaded: $filename"
    else
        echo "Asset not found: $filename"
    fi
done

echo ""
echo "✅ Eaglercraft files downloaded successfully!"
echo "📁 Files saved to: $EAGLECRAFT_DIR"
echo ""
echo "To access Eaglercraft:"
echo "  http://localhost/eaglercraft-wasm/"
echo ""
echo "To update to latest version, run this script again."