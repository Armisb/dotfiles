#!/usr/bin/env bash

WORKSPACE="spotify"
APP_CLASS="spotify"

# Always go to spotify workspace
hyprctl dispatch workspace "$WORKSPACE"

# If not running, launch it
if ! pgrep -x "$APP_CLASS" >/dev/null; then
    "$APP_CLASS" &
fi

# Wait until window exists (max ~3 seconds)
for i in {1..30}; do
    WINDOW=$(hyprctl clients -j | jq -r \
        ".[] | select(.class | ascii_downcase == \"$APP_CLASS\") | .address" | head -n1)

    if [ -n "$WINDOW" ] && [ "$WINDOW" != "null" ]; then
        hyprctl dispatch focuswindow address:"$WINDOW"
        exit 0
    fi

    sleep 0.1
done
