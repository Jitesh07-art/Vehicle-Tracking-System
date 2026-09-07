@echo off
REM Vehicle Tracking System - Windows Setup Script
REM Automated setup for Windows systems

setlocal enabledelayedexpansion

REM Configuration
set PROJECT_NAME=Vehicle Tracking System
set DB_NAME=vehicle_tracking
set DB_USER=root
set DB_PASSWORD=root

REM Colors (using ANSI codes)
cls

echo.
echo ================================================================
echo %PROJECT_NAME% - Windows Setup
echo ================================================================
echo.

REM Check Java
echo Checking Java installation...
java -version >nul 2>&1
if errorlevel 1 (
    echo Error: Java is not installed or not in PATH
    echo Please install Java 17+ from https://www.oracle.com/java/
    pause
    exit /b 1
)
for /f tokens^=2 %%i in ('java -version 2^>^&1 ^| grep "version"') do set JAVA_VERSION=%%i
echo ^✓ Java %JAVA_VERSION% found

REM Check Maven
echo Checking Maven installation...
mvn -version >nul 2>&1
if errorlevel 1 (
    echo Error: Maven is not installed or not in PATH
    echo Please install Maven from https://maven.apache.org/
    pause
    exit /b 1
)
echo ^✓ Maven found

REM Check MySQL
echo Checking MySQL installation...
mysql --version >nul 2>&1
if errorlevel 1 (
    echo Error: MySQL is not installed or not in PATH
    echo Please install MySQL from https://www.mysql.com/
    pause
    exit /b 1
)
echo ^✓ MySQL found

REM Check Python
echo Checking Python installation...
python --version >nul 2>&1
if errorlevel 1 (
    echo Warning: Python 3 not found
    echo GPS simulator will not work without Python
    echo Download from https://www.python.org/
) else (
    echo ^✓ Python found
)

echo.
echo ================================================================
echo Configuration
echo ================================================================
echo.

echo Database Name: %DB_NAME%
echo Database User: %DB_USER%
echo Database Password: (hidden)

set /p DB_PASSWORD="Enter MySQL password (press Enter for 'root'): "
if "%DB_PASSWORD%"=="" set DB_PASSWORD=root

echo.
echo ================================================================
echo Setting up Database
echo ================================================================
echo.

echo Creating database: %DB_NAME%

REM Create database and import schema
mysql -u %DB_USER% -p%DB_PASSWORD% < database\schema.sql
if errorlevel 1 (
    echo Error: Failed to import database schema
    echo Please verify MySQL credentials and ensure MySQL is running
    pause
    exit /b 1
)

echo ^✓ Database setup complete

echo.
echo ================================================================
echo Building Project
echo ================================================================
echo.

echo Running Maven build...
call mvn clean install -DskipTests

if errorlevel 1 (
    echo Error: Maven build failed
    pause
    exit /b 1
)

echo ^✓ Build complete

REM Install Python packages if Python is available
where python >nul 2>&1
if not errorlevel 1 (
    echo.
    echo ================================================================
    echo Installing Python Packages
    echo ================================================================
    echo.
    
    echo Installing requests module...
    pip install requests
    
    echo ^✓ Python packages installed
)

echo.
echo ================================================================
echo Setup Complete!
echo ================================================================
echo.
echo Next steps:
echo 1. Open src\main\resources\application.properties
echo 2. Verify database credentials match your MySQL setup
echo 3. Start backend: mvn spring-boot:run
echo 4. Open browser: http://localhost:8080
echo 5. Run simulator: python scripts\simulator.py --vehicle-id 1
echo.
echo For detailed information, see README.md
echo.
pause
