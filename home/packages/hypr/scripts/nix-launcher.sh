#!/usr/bin/env bash

# --- Configuration ---
CACHE_DIR="$HOME/.cache/nix-runner"
CACHE_FILE="$CACHE_DIR/packages.txt"
TIMESTAMP_FILE="$CACHE_DIR/last_updated"
HISTORY_FILE="$CACHE_DIR/history.txt"
# 7 days in seconds
ONE_WEEK_SECONDS=$((7 * 24 * 60 * 60))

# Create directory if it doesn't exist
mkdir -p "$CACHE_DIR"
touch "$HISTORY_FILE"

# --- Functions ---

update_cache() {
  notify-send "Nix Runner" "Updating package list cache..."
  # Generate list: name only, stripped of 'nixos.' or 'nixpkgs.' prefixes
  nix-env -qaP | awk '{print $1}' | sed -E 's/^nix(os|pkgs)\.//' | sort -u >"$CACHE_FILE"
  date +%s >"$TIMESTAMP_FILE"
  notify-send "Nix Runner" "Cache updated!"
}

# --- Cache Logic ---

# 1. Check if cache exists
if [ ! -f "$CACHE_FILE" ] || [ ! -f "$TIMESTAMP_FILE" ]; then
  update_cache
else
  # 2. Check if cache is older than a week
  NOW=$(date +%s)
  LAST_UPDATED=$(cat "$TIMESTAMP_FILE")
  DIFF=$((NOW - LAST_UPDATED))

  if [ "$DIFF" -gt "$ONE_WEEK_SECONDS" ]; then
    # Update in background
    update_cache &
  fi
fi

# --- Menu Logic ---

# Prepare the list: History first, then Cache (excluding items already in history)
if [ -f "$CACHE_FILE" ]; then
  # We use temporary variable to avoid subshell issues in some strict modes, but standard bash is fine here.
  # The grep -vxf avoids showing history items twice.
  LIST=$(cat "$HISTORY_FILE" <(grep -vxf "$HISTORY_FILE" "$CACHE_FILE"))
else
  LIST=$(cat "$HISTORY_FILE")
fi

set +e

# Launch Rofi
# We unbind alt-accept so Shift+Return can be used for custom-1
PKG=$(echo "$LIST" | rofi -dmenu \
  -p "  Run" \
  -theme-str 'entry { placeholder: "Search... (Enter: Silent | Shift+Enter: Terminal)"; }' \
  -kb-accept-alt "" \
  -kb-custom-1 "Shift+Return")

EXIT_CODE=$?

# If cancelled
if [ -z "$PKG" ]; then
  exit 0
fi

set -e

# --- History Management ---

# Remove package from history if it exists, then add to top
grep -vx "$PKG" "$HISTORY_FILE" >"$HISTORY_FILE.tmp"
echo "$PKG" | cat - "$HISTORY_FILE.tmp" >"$HISTORY_FILE"
rm "$HISTORY_FILE.tmp"

# --- Execution ---

export NIXPKGS_ALLOW_UNFREE=1

if [ "$EXIT_CODE" -eq 10 ]; then
  # Mode 1: Terminal (Shift+Enter)
  # Note: We quote $PKG inside the sh -c string to keep shellcheck happy and safe
  kitty --title "Nix Run: $PKG" sh -c "echo 'Fetching $PKG...'; nix run --impure nixpkgs#\"$PKG\"; echo '';"
else
  # Mode 2: Silent (Enter)
  notify-send "Nix Run" "Fetching and launching $PKG..."
  nohup nix run --impure nixpkgs#"$PKG" >/dev/null 2>&1 &
fi
