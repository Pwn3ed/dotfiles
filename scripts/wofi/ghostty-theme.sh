#!/bin/bash

CONFIG="$HOME/.config/ghostty/config"

STYLES=("GHOSTTY THEMES LIST" "Twilight" "GruvboxLight" "Jackie Brown")

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
