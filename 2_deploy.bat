@echo off
echo === Step 2: Deploy V2Ray ===
echo.

cd /d "%~dp0"

where railway >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Railway CLI not found. Run: npm install -g @railway/cli
    pause
    exit /b 1
)

echo [1/2] Creating new project...
railway init

echo.
echo [2/2] Deploying...
railway up

echo.
echo === Done! Getting domain... ===
railway domain

echo.
echo Copy the domain above and send it to get your v2rayNG URI
pause
