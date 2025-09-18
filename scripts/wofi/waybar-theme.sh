#!/bin/bash

STYLES=("WAYBAR THEMES LIST" "default" "too-much" "minimal")

MENU=$(printf "%s\n" "${STYLES[@]}")

# Show the menu and get user choice
CHOICE=$(echo "$MENU" | wofi --dmenu --prompt "Waybar Style List")

if [ -z "$CHOICE" ] || [[ "$CHOICE" == "WAYBAR STYLE LIST" ]]; then
  exec "$HOME/dotfiles/scripts/wofi/menus.sh"
  exit
fi

notify-send --app-name=Waybar "Changing style to $CHOICE"

# Run corresponding command based on choice
case "$CHOICE" in
  "default")
    killall waybar
    waybar &
    exit
    ;;
  "too-much")
    killall waybar
    waybar --config ~/.config/waybar/full.jsonc --style ~/.config/waybar/full.css &
    exit
    ;;
  "minimal")
    killall waybar
    waybar --config ~/.config/waybar/minimal.jsonc --style ~/.config/waybar/minimal.css &
    exit
    ;;
esac
