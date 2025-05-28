#!/bin/bash

EMULATORS=("EMULATORS" "gba" "nds" "snes")

MENU=$(printf "%s\n" "${EMULATORS[@]}")

# Show the menu and get user choice
CHOICE=$(echo "$MENU" | wofi --dmenu --prompt "Emulatos List")

if [ -z "$CHOICE" ] || [[ "$CHOICE" == "EMULATORS" ]]; then
  exec "$HOME/dotfiles/scripts/wofi/menus.sh"
  exit
fi

notify-send --app-name=Emulator "opening $CHOICE"

case "$CHOICE" in
  "gba")
    mgba-qt &
    ;;
  "nds")
    desmume &
    ;;
  "snes")
    snes9x &
    ;;
esac

exit
