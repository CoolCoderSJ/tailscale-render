#!/usr/bin/env bash

/render/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1055 &
PID=$!

/render/tailscale up --hostname="${RENDER_SERVICE_NAME}" --advertise-exit-node &
/render/tailscale web --listen 0.0.0.0:$PORT &

export ALL_PROXY=socks5://localhost:1055/
tailscale_ip=$(/render/tailscale ip)
echo "Tailscale is up at IP ${tailscale_ip}"

wait ${PID}
