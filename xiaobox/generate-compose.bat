@echo off
REM XIAOBOX Docker Compose Generator for Windows
REM Generates docker-compose.yml from config.yml

echo XIAOBOX Configuration System
echo ============================
echo.

REM Check if Python 3 is available
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python 3 is required but not installed.
    echo Please install Python 3 from https://python.org
    echo Press any key to exit...
    pause >nul
    exit /b 1
)

REM Check if PyYAML is available
python -c "import yaml" >nul 2>&1
if errorlevel 1 (
    echo [ERROR] PyYAML is required but not installed.
    echo Install with: pip install PyYAML
    echo Or run: python -m pip install PyYAML
    echo Press any key to exit...
    pause >nul
    exit /b 1
)

REM Run the Python generator
echo Generating docker-compose.yml from config.yml...
python generate-compose.py
if errorlevel 1 (
    echo [ERROR] Failed to generate docker-compose.yml
    echo Press any key to exit...
    pause >nul
    exit /b 1
)

echo.
echo [SUCCESS] Configuration applied successfully!
echo.
echo To apply changes, run:
echo   cd docker
echo   docker-compose down
echo   docker-compose up -d
echo.
echo Press any key to exit...
pause >nul