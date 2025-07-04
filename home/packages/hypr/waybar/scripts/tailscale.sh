#!/usr/bin/env zsh

if tailscale status 2>&1 | grep -q "Tailscale is stopped"; then
    echo '{"text": " Tailscale", "class": "custom-tailscale", "alt": "tailscale_offline"}'
else
    echo '{"text": " Tailscale", "class": "custom-tailscale", "alt": "tailscale_online"}'
fi
