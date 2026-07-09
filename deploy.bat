@echo off
cd /d "%~dp0"
echo === Step 1: Login ===
railway login
echo.
echo === Step 2: Init project ===
railway init
echo.
echo === Step 3: Deploy ===
railway up
echo.
echo === Step 4: Your domain ===
railway domain
echo.
echo Copy the domain above and send it to get your URI
pause
