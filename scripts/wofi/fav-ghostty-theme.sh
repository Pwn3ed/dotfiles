#!/bin/bash

CONFIG="$HOME/.config/ghostty/config"

i want to get all the files names inside this dir and use it as choices in my bash script
ls /usr/share/ghostty/themes

STYLES=("GHOSTTY THEMES LIST" "Retro" "Twilight" "GruvboxLight" "Jackie Brown" "coffee_theme" "tokyonight-day")

MENU=$(printf "%s\n" "${STYLES[@]}")

# Show the menu and get user choice
CHOICE=$(echo "$MENU" | wofi --dmenu --prompt "Ghostty Theme List")

# If no choice or the header is selected, exit or rerun menu
if [ -z "$CHOICE" ] || [[ "$CHOICE" == "GHOSTTY THEMES LIST" ]]; then
  exec "$HOME/dotfiles/scripts/wofi/menus.sh"
  exit
fi

notify-send --app-name=Ghostty "Changing theme to $CHOICE"

sed -i -E "s/^theme *= *.*/theme = $CHOICE/" "$CONFIG"
