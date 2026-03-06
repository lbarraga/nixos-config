#!/usr/bin/env zsh

STATE=$(playerctl -p spotify status)

# Choose icon
if [[ "$STATE" == "Playing" ]]; then
  ICON="" # Pause icon
else
  ICON="" # Play icon
fi

echo "{\"text\":\"$ICON\",\"tooltip\":\"Spotify $STATE\"}"
