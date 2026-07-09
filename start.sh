#!/bin/bash
set -e

TARGET_PORT="${PORT:-8080}"
echo "[start.sh] PORT=$TARGET_PORT"

# V2Ray слушает на фиксированном порту 10000
echo "[start.sh] Starting V2Ray on port 10000..."
v2ray run -config /usr/local/etc/v2ray/config.json &
V2RAY_PID=$!
echo "[start.sh] V2Ray PID=$V2RAY_PID"

# Подставляем порт в nginx
echo "[start.sh] Configuring nginx on port $TARGET_PORT..."
sed -i "s/listen 8080/listen $TARGET_PORT/" /etc/nginx/nginx.conf

# Тестируем конфиг nginx
nginx -t

echo "[start.sh] Starting nginx..."
nginx -g "daemon off;"
