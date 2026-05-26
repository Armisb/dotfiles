#!/bin/bash

WALLPAPER_DIR="$HOME/img/main/wallpapers"
CURRENT_WALLPAPER_LINK="$HOME/.config/hypr/current_wallpaper"

selected_wallpaper=$(for a in "$WALLPAPER_DIR"/*; do
    echo -en "$(basename "${a%.*}")\0icon\x1f$a\n"
done | rofi -dmenu -i -p "wallpaper" -markup-rows -width 40 -lines 15 -theme ~/.config/rofi/wallpaper-switcher.rasi)


image_fullname_path=$(find "$WALLPAPER_DIR" -type f -name "$selected_wallpaper.*" | head -n 1)

swww img "$image_fullname_path" --transition-type any --transition-duration 2

ln -sf "$image_fullname_path" "$CURRENT_WALLPAPER_LINK"
