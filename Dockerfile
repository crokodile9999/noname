FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
# Pin the version so builds are reproducible and don't break
# silently when a new upstream release changes something.
# Bump this manually when you want to upgrade.
ENV V2RAY_VERSION=v5.51.2

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    ca-certificates \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем V2Ray вручную без systemd
RUN curl -fL "https://github.com/v2fly/v2ray-core/releases/download/${V2RAY_VERSION}/v2ray-linux-64.zip" -o /tmp/v2ray.zip \
    && unzip /tmp/v2ray.zip -d /tmp/v2ray \
    && mv /tmp/v2ray/v2ray /usr/local/bin/v2ray \
    && chmod +x /usr/local/bin/v2ray \
    && mkdir -p /usr/local/etc/v2ray /usr/local/share/v2ray \
    && mv /tmp/v2ray/geoip.dat /usr/local/share/v2ray/ \
    && mv /tmp/v2ray/geosite.dat /usr/local/share/v2ray/ \
    && rm -rf /tmp/v2ray /tmp/v2ray.zip

COPY config.json /usr/local/etc/v2ray/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
