#!/bin/bash


WALLPAPER_DIR="$HOME/img/main/wallpapers"
CURRENT_WALLPAPER_LINK="$HOME/.config/hypr/current_wallpaper"


WALLPAPER=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f | shuf -n 1)

swww img "$WALLPAPER" --transition-type any --transition-duration 2

ln -sf "$WALLPAPER" "$CURRENT_WALLPAPER_LINK"