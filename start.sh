#!/bin/bash
set -e

CONFIG="/usr/local/etc/v2ray/config.json"

# Railway injects $PORT at runtime — patch the config before starting
if [ -n "$PORT" ]; then
  echo "[start.sh] Using PORT=$PORT"
  sed -i "s/8080/$PORT/g" "$CONFIG"
else
  echo "[start.sh] \$PORT not set, defaulting to 8080"
fi

# Optional: print UUID reminder
echo "[start.sh] Starting V2Ray..."
exec v2ray run -config "$CONFIG"
