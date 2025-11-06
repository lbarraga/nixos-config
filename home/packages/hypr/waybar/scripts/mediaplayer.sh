#!/usr/bin/env zsh

# Get artist and title (even if paused)
artist=$(playerctl -p spotify metadata artist 2>/dev/null | sed 's/&/&amp;/g')
title=$(playerctl -p spotify metadata title 2>/dev/null | sed 's/&/&amp;/g')

echo '{ "text": "'"$artist - $title"'", "class": "custom-spotify", "alt": "Spotify"}'
