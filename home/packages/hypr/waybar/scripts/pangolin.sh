#!/usr/bin/env bash

# --- ICONS ---
ICON_DIRECT=" "
ICON_RELAY=" "
ICON_DOWN=" "
ICON_UNKNOWN=" "
# -------------

# 1. Check if Service is active
if ! systemctl is-active --quiet olm; then
  echo "{\"text\": \"$ICON_DOWN\", \"class\": \"custom-pangolin\", \"alt\": \"offline\", \"tooltip\": \"Olm Service is Stopped\"}"
  exit 0
fi

# 2. Get Relay Status
# Filters for exactly "true" or "false" at the end of the line
RELAY_STATUS=$(pangolin status 2>/dev/null | awk '$NF ~ /^(true|false)$/ {print $NF}')

# 3. JSON Output Logic
if [[ "$RELAY_STATUS" == "true" ]]; then
  # Relay
  echo "{\"text\": \"$ICON_RELAY\", \"class\": \"custom-pangolin\", \"alt\": \"relay\", \"tooltip\": \"Connected via Relay\"}"

elif [[ "$RELAY_STATUS" == "false" ]]; then
  # Direct
  echo "{\"text\": \"$ICON_DIRECT\", \"class\": \"custom-pangolin\", \"alt\": \"direct\", \"tooltip\": \"Direct Connection\"}"

else
  # Unknown
  echo "{\"text\": \"$ICON_UNKNOWN\", \"class\": \"custom-pangolin\", \"alt\": \"unknown\", \"tooltip\": \"Status Unknown\"}"
fi
