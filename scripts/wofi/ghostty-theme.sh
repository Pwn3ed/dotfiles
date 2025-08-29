#!/bin/bash

CONFIG=$HOME/.config/ghostty/config
THEMES_DIR=/usr/share/ghostty/themes

STYLES=()
while IFS= read -r -d $'\0' theme; do
  STYLES+=("$(basename "$theme")")
done < <(find "$THEMES_DIR" -maxdepth 1 -type f -print0 | sort -z)

CHOICE=$(printf '%s\n' "${STYLES[@]}" | wofi --dmenu --prompt "Ghostty Theme")

if [ -n "$CHOICE" ]; then
  inotify-send --app-name=Ghostty "Changing theme to $CHOICE"
  sed -i "s/^theme *=.*/theme = $CHOICE/g" "$CONFIG"
fi

