@echo off
echo === Redeploy to existing Railway project ===
cd /d "%~dp0"

where railway >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Railway CLI not found. Run 1_setup.bat first.
    pause
    exit /b 1
)

if not exist ".railway" (
    echo [!] This folder isn't linked to a Railway project yet.
    echo     Run 1_setup.bat first.
    pause
    exit /b 1
)

echo [1/2] Deploying current code...
railway up

echo.
echo [2/2] Current domain:
railway domain

echo.
echo Done. If this is the first deploy and no domain was printed above,
echo run: railway domain    (this creates one, only needed once)
pause
