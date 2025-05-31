#!/bin/bash

STYLES=("SCRIPTS LIST" "config sync" "shell sync")

MENU=$(printf "%s\n" "${STYLES[@]}")

DIR="$HOME/dotfiles/scripts/utils"

FILES=$(ls "$DIR")

MENU+=$(printf "\n%s" "${FILES[@]}")

# Show the menu and get user choice
CHOICE=$(echo "$MENU" | wofi --dmenu --prompt "Scripts List")

if [ -z "$CHOICE" ] || [[ "$CHOICE" == "SCRIPTS LIST" ]]; then
  exec "$HOME/dotfiles/scripts/wofi/menus.sh"
  exit
fi

notify-send --app-name=Scripts "Running $CHOICE"

# Run corresponding command based on choice
case "$CHOICE" in
  "config sync")
    exec env RUN_SCRIPT=true "$HOME/dotfiles/scripts/update-config-files.sh"
    exit
    ;;
  "shell sync")
    exec env RUN_SCRIPT=true "$HOME/dotfiles/scripts/update-zsh-files.sh"
    exit
    ;;
  *)
    OUTPUT="$("$DIR/$CHOICE")"
    notify-send --app-name=Notification "$OUTPUT"
    exit
    ;;
esac
