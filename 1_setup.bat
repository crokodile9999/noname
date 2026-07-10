@echo off
echo === Setup: Railway login + project init (run this ONCE) ===
cd /d "%~dp0"

where railway >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Railway CLI not found. Installing...
    npm install -g @railway/cli
    if %errorlevel% neq 0 (
        echo [!] Install failed. Make sure Node.js is installed: https://nodejs.org
        pause
        exit /b 1
    )
)

echo [1/2] Login (browser will open)...
railway login

echo.
echo [2/2] Creating project and linking this folder...
railway init

echo.
echo Setup done. From now on, ONLY use redeploy.bat to ship updates.
echo Do NOT run this script again - it would create a new project/domain.
pause
