#!/bin/bash

MONITOR="eDP-1"

STATUS=$(cat /sys/class/power_supply/AC*/online 2>/dev/null)

if [ "$STATUS" = "1" ]; then
  # Plugged in
  hyprctl keyword monitor "$MONITOR,2800x1800@120,0x0,1.88"
else
  # Battery
  hyprctl keyword monitor "$MONITOR,1920x1080@60,auto,1.88"
fi
