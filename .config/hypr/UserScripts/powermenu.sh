#!/bin/bash

# i3 Power Menu — rofi-based
# Keybinds shown in prompt; selected action runs i3-exit.sh
# Dependencies: rofi, i3-exit.sh (in same dir or on PATH)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXIT_SCRIPT="$SCRIPT_DIR/i3-exit.sh"

# Fall back to PATH if not found next to this script
if [ ! -f "$EXIT_SCRIPT" ]; then
  EXIT_SCRIPT="i3-exit.sh"
fi

# ── Options (keybind shown in label) ──────────────────────
lock="  Lock        [l]"
suspend="  Suspend     [s]"
logout="  Logout      [e]"
hibernate="  Hibernate   [h]"
reboot="  Restart     [r]"
shutdown="  Shutdown    [s]"

# ── Rofi theme (inline) ────────────────────────────────────
ROFI_THEME='
configuration {
    font: "JetBrains Mono 13";
    show-icons: false;
}

* {
    bg:         #31285a;
    bg-alt:     #a193c1;
    fg:         #ffffff;
    fg-dim:     #eeeeee;
    accent:     #c0acc2;
    urgent:     #c0504d;
    selected-bg: #1e1e1e;
    border-col:  #2a2a2a;

    background-color: transparent;
    text-color:       @fg;
}

window {
    background-color: @bg;
    border:           -25px;
    border-color:     @border-col;
    border-radius:    10px;
    padding:          0;
    width:            280px;
}

mainbox {
    background-color: @bg;
    children:         [ inputbar, listview ];
    spacing:          0;
}

inputbar {
    background-color: @bg-alt;
    padding:          14px 18px 12px;
    border:           0 0 1px 0;
    border-color:     @border-col;
    children:         [ prompt ];
}

prompt {
    background-color: transparent;
    text-color:       @accent;
    font:             "JetBrains Mono 11";
    letter-spacing:   2px;
}

listview {
    background-color: @bg;
    padding:          8px 0;
    lines:            6;
    scrollbar:        false;
    spacing:          0;
}

element {
    background-color: transparent;
    padding:          10px 20px;
    border-radius:    0;
    spacing:          10px;
    cursor:           pointer;
}

element normal.normal {
    background-color: transparent;
    text-color:       @fg;
}

element selected.normal {
    background-color: @selected-bg;
    text-color:       @accent;
    border:           0 0 0 2px;
    border-color:     @accent;
}

element-text {
    background-color: transparent;
    text-color:       inherit;
    vertical-align:   0.5;
}
'

# ── Show menu ──────────────────────────────────────────────
# Direct keybinds use -kb-custom-N; rofi exits with code 10+N
# kb-custom-1  → l → lock
# kb-custom-2  → s → suspend
# kb-custom-3  → e → logout
# kb-custom-4  → h → hibernate
# kb-custom-5  → r → reboot
# kb-custom-6  → S → shutdown  (uppercase to avoid conflict with suspend)

chosen=$(printf '%s\n' \
  "$lock" \
  "$suspend" \
  "$logout" \
  "$hibernate" \
  "$reboot" \
  "$shutdown" |
  rofi \
    -dmenu \
    -p "POWER" \
    -selected-row 0 \
    -kb-row-up "k,Up" \
    -kb-row-down "j,Down" \
    -kb-accept-entry "Return" \
    -kb-custom-1 "l" \
    -kb-custom-2 "u" \
    -kb-custom-3 "e" \
    -kb-custom-4 "h" \
    -kb-custom-5 "r" \
    -kb-custom-6 "s" \
    -theme-str "$ROFI_THEME")

rofi_exit=$?

# ── Dispatch ───────────────────────────────────────────────
# Direct keybind pressed (exit code 10–15) — act immediately
case $rofi_exit in
10)
  "$EXIT_SCRIPT" lock
  exit 0
  ;;
11)
  "$EXIT_SCRIPT" suspend
  exit 0
  ;;
12)
  "$EXIT_SCRIPT" logout
  exit 0
  ;;
13)
  "$EXIT_SCRIPT" hibernate
  exit 0
  ;;
14)
  "$EXIT_SCRIPT" reboot
  exit 0
  ;;
15)
  "$EXIT_SCRIPT" shutdown
  exit 0
  ;;
esac

# Enter pressed — dispatch based on highlighted item
case "$chosen" in
"$lock") "$EXIT_SCRIPT" lock ;;
"$suspend") "$EXIT_SCRIPT" suspend ;;
"$logout") "$EXIT_SCRIPT" logout ;;
"$hibernate") "$EXIT_SCRIPT" hibernate ;;
"$reboot") "$EXIT_SCRIPT" reboot ;;
"$shutdown") "$EXIT_SCRIPT" shutdown ;;
esac
