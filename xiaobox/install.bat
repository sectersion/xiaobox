@echo off
REM XIAOBOX Installation Script for Windows
REM Sets up the XIAOBOX environment on Windows

echo XIAOBOX Windows Installation
echo ============================
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Docker is not installed.
    echo Please install Docker Desktop from: https://docker.com/products/docker-desktop
    echo Press any key to exit...
    pause >nul
    exit /b 1
)

REM Check if Docker Compose is available
docker-compose --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Docker Compose is not available.
    echo Please ensure Docker Desktop is properly installed.
    echo Press any key to exit...
    pause >nul
    exit /b 1
)

REM Check if Python 3 is available
python --version >nul 2>&1
if errorlevel 1 (
    echo [WARNING] Python 3 is not installed.
    echo Python is required for the configuration system.
    echo Please install Python 3 from: https://python.org
    echo.
    echo Continuing without Python - manual configuration required...
)

REM Check if PyYAML is available (if Python exists)
python --version >nul 2>&1
if not errorlevel 1 (
    python -c "import yaml" >nul 2>&1
    if errorlevel 1 (
        echo [WARNING] PyYAML is not installed.
        echo Install with: pip install PyYAML
        echo Or: python -m pip install PyYAML
        echo.
        echo Continuing without PyYAML - manual configuration required...
    )
)

echo [INFO] Docker and Docker Compose are properly installed.
echo.

REM Create necessary directories
if not exist "docker\server\mc" mkdir docker\server\mc
if not exist "docker\server\bungee" mkdir docker\server\bungee
if not exist "docker\code-workspace" mkdir docker\code-workspace

echo [INFO] Created necessary directories.
echo.

REM Generate initial docker-compose.yml
if exist "generate-compose.py" (
    echo [INFO] Generating initial docker-compose.yml...
    python generate-compose.py 2>nul
    if errorlevel 1 (
        echo [WARNING] Config generation failed - using default docker-compose.yml
    ) else (
        echo [SUCCESS] Generated docker-compose.yml from config.yml
    )
) else (
    echo [INFO] Using existing docker-compose.yml
)

echo.
echo [SUCCESS] XIAOBOX installation completed!
echo.
echo Next steps:
echo 1. Edit config.yml to customize your setup
echo 2. Run generate-compose.bat to apply changes
echo 3. Run start.bat to launch services
echo.
echo Access URLs after starting:
echo   - Main site: http://localhost
echo   - VS Code: http://localhost:8082 (password: student)
echo   - IRC Chat: http://localhost:9000
echo.
echo Press any key to exit...
pause >nul