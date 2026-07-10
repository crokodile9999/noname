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
if ! grep -q "listen 8080" /etc/nginx/nginx.conf; then
    echo "[start.sh] ERROR: 'listen 8080' not found in nginx.conf - refusing to start with wrong port"
    exit 1
fi
sed -i "s/listen 8080/listen $TARGET_PORT/" /etc/nginx/nginx.conf

# Тестируем конфиг nginx
nginx -t

# Если v2ray уже упал на старте - лучше остановиться сразу, а не поднимать
# nginx поверх мёртвого бэкенда
if ! kill -0 "$V2RAY_PID" 2>/dev/null; then
    echo "[start.sh] ERROR: v2ray exited immediately, check config.json"
    exit 1
fi

echo "[start.sh] Starting nginx..."
nginx -g "daemon off;"
