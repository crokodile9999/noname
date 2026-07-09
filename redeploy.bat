@echo off
echo =============================
echo   V2Ray Railway Redeploy
echo =============================
echo.

cd /d "%~dp0"

where railway >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Railway CLI not found. Installing...
    npm install -g @railway/cli
    if %errorlevel% neq 0 (
        echo [!] Install error. Make sure Node.js is installed: https://nodejs.org
        pause
        exit /b 1
    )
)

echo [1/3] Login to Railway...
echo     Browser will open - login there
echo     After login come back here and press any key
echo.
railway login
echo.
echo Done? Press any key to continue...
pause >nul

echo.
echo [2/3] Creating new project...
railway init

echo.
echo [3/3] Deploying...
railway up

echo.
echo =============================
echo   Done! Getting domain...
echo =============================
railway domain

echo.
echo Copy the domain above and send it to get your v2rayNG URI
pause
