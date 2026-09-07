@echo off
REM Vehicle Tracking System - GPS Simulator Batch Script for Windows
REM Simulates vehicle movement by sending location updates to the backend

setlocal enabledelayedexpansion

REM Configuration
set PYTHON_CMD=python
set API_URL=http://localhost:8080/api
set SCRIPT_DIR=%~dp0

echo.
echo ================================================================
echo Vehicle Tracking System - GPS Simulator (Windows)
echo ================================================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo Error: Python is not installed or not in PATH
    echo Please install Python 3 from https://www.python.org
    pause
    exit /b 1
)

echo ^✓ Python found
echo.

REM Check if requests module is installed
python -c "import requests" >nul 2>&1
if errorlevel 1 (
    echo Installing required Python package: requests
    python -m pip install requests
)

echo.
echo Choose simulation mode:
echo 1. All vehicles (3 vehicles, 10 minutes)
echo 2. Single vehicle
echo 3. Quick test (30 seconds)
echo 4. Exit
echo.

set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" (
    echo.
    echo Starting simulators for all vehicles...
    echo.
    
    REM Start vehicle 1 in background
    start "Vehicle 1 Simulator" python "%SCRIPT_DIR%simulator.py" ^
        --vehicle-id 1 --speed 50 --route city --duration 600 ^
        --api-url %API_URL%
    
    timeout /t 1 /nobreak
    
    REM Start vehicle 2 in background
    start "Vehicle 2 Simulator" python "%SCRIPT_DIR%simulator.py" ^
        --vehicle-id 2 --speed 80 --route highway --duration 600 ^
        --api-url %API_URL%
    
    timeout /t 1 /nobreak
    
    REM Start vehicle 3 in background
    start "Vehicle 3 Simulator" python "%SCRIPT_DIR%simulator.py" ^
        --vehicle-id 3 --speed 45 --route around --duration 600 ^
        --api-url %API_URL%
    
    echo.
    echo All simulators started. Check the command windows for progress.
    echo Press any key to continue...
    pause >nul
    
) else if "%choice%"=="2" (
    set /p vehicle_id="Enter vehicle ID (1-3): "
    set /p speed="Enter speed in km/h (default 50): "
    if "!speed!"=="" set speed=50
    set /p route="Enter route type (city/highway/around) (default city): "
    if "!route!"=="" set route=city
    
    python "%SCRIPT_DIR%simulator.py" ^
        --vehicle-id !vehicle_id! --speed !speed! --route !route! ^
        --duration 600 --api-url %API_URL%
    
) else if "%choice%"=="3" (
    echo.
    echo Running 30-second quick test...
    echo.
    
    python "%SCRIPT_DIR%simulator.py" ^
        --vehicle-id 1 --speed 50 --route city --duration 30 ^
        --api-url %API_URL%
    
) else (
    echo Exiting...
    exit /b 0
)

echo.
echo Simulator completed
echo.
pause
