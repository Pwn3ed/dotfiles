#!/bin/bash

DIR="$HOME/wallpapers"

# FILES=($(ls "$DIR" | sed 's/\.png$//' | sed 's/\.jpg$//'))
FILES=$(ls "$DIR")

# Build indexed menu
MENU="WALLPAPERS LIST"
for i in "${!FILES[@]}"; do
    MENU+="\n${FILES[$i]}"
done

# Show menu and capture selection
CHOICE=$(echo -e "$MENU" | wofi --dmenu --prompt "Menu List")

if [ -z "$CHOICE" ] || [[ "$CHOICE" == "WALLPAPERS LIST" ]]; then
  exec "$HOME/dotfiles/scripts/wofi/menus.sh"
  exit
fi

notify-send --app-name=Hyprpaper "Changing wallpaper to $CHOICE"

hyprctl hyprpaper wallpaper ",$DIR/$CHOICE"
