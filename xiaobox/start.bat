@echo off
REM XIAOBOX Start Script for Windows
REM Starts all Docker containers for the XIAOBOX project

echo Starting XIAOBOX Services...

REM Check if Docker is running
docker info >nul 2>&1
if errorlevel 1 (
    echo Docker is not running. Please start Docker Desktop first.
    echo Press any key to exit...
    pause >nul
    exit /b 1
)

REM Check if Docker Compose is available
docker-compose --version >nul 2>&1
if errorlevel 1 (
    echo Docker Compose is not installed.
    echo Press any key to exit...
    pause >nul
    exit /b 1
)

REM Generate docker-compose.yml from config if script exists
if exist "generate-compose.py" (
    echo Generating docker-compose.yml from config.yml...
    python generate-compose.py 2>nul
    if errorlevel 1 (
        echo [WARNING] Config generation failed - using existing docker-compose.yml
    )
) else (
    echo Config generation script not found - using existing docker-compose.yml
)

REM Navigate to docker directory
if exist "docker" (
    cd docker
) else (
    echo Docker directory not found. Please run this script from the xiaobox directory.
    echo Press any key to exit...
    pause >nul
    exit /b 1
)

REM Start all services
echo Starting all containers...
docker-compose up -d

REM Wait a moment for services to start
timeout /t 5 /nobreak >nul

REM Check status
echo.
echo Service Status:
docker-compose ps

echo.
echo XIAOBOX Services Started!
echo.
echo Access your services:
echo    - Main site: http://localhost
echo    - Eaglercraft: http://localhost
echo    - VS Code Server: http://localhost:8082 (password: student)
echo    - TheLounge IRC: http://localhost:9000
echo    - Traefik Dashboard: http://localhost:8080
echo.
echo To stop all services: docker-compose down
echo To view logs: docker-compose logs -f
echo To reconfigure: edit ..\config.yml and run ..\generate-compose.bat
echo.
echo Press any key to exit...
pause >nul