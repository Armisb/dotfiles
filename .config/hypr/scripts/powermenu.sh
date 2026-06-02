#!/usr/bin/env bash

options="  Shutdown\t[s]
  Lock\t[l]
  Logout\t[e]
󰒲  Hibernate\t[h]
󰤄  Suspend\t[u]
  Restart\t[r]"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu" \
  -theme-str 'listview { columns: 1; }' \
  -kb-custom-1 "s" \
  -kb-custom-2 "l" \
  -kb-custom-3 "e" \
  -kb-custom-4 "h" \
  -kb-custom-5 "u" \
  -kb-custom-6 "r")

case $? in
10) systemctl poweroff ;;    # s
11) hyprlock ;;              # l
12) hyprctl dispatch exit ;; # e
13) systemctl hibernate ;;   # h
14) systemctl suspend ;;     # u
15) systemctl reboot ;;      # r
0)
  case "$chosen" in
  *Shutdown*) systemctl poweroff ;;
  *Lock*) hyprlock ;;
  *Logout*) hyprctl dispatch exit ;;
  *Hibernate*) systemctl hibernate ;;
  *Suspend*) systemctl suspend ;;
  *Restart*) systemctl reboot ;;
  esac
  ;;
esac
