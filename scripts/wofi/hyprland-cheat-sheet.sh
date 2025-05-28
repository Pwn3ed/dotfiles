#!/bin/bash

KEYMAPS=(
  "super + e"
  "super + q"
  "super + n"
  "super + hjkl"
  "super + 123..."
  "super + m"
  "super + M"
  "super + v"
  "super + r"
  "super + p"
  "super + P"
  "super + B"
  "super + F"
)

RESULTS=(
  "open terminal"
  "kill current window"
  "open navigator"
  "change window"
  "change workspace"
  "open application launcher"
  "open menus"
  "toggle floatwindow"
  "reload waybar config"
  "region screenshot"
  "fullscreen screenshot"
  "Hide waybar"
  "window to fullscreen"
)

# Combine keymaps and descriptions into lines like: "super + e  —  open terminal"
MENU=""
MENU+="CHEAT SHEET"
for i in "${!KEYMAPS[@]}"; do
  MENU+="\n${KEYMAPS[i]}  —  ${RESULTS[i]}"
done

# Show menu and get choice
CHOICE=$(echo -e "$MENU" | wofi --dmenu --prompt "Hyprland Cheat Sheet")

if [ -z "$CHOICE" ] || [[ "$CHOICE" == "CHEAT SHEET" ]]; then
  exec "$HOME/dotfiles/scripts/wofi/menus.sh"
  exit
fi

notify-send --urgency=critical --app-name=Hyprland "Keymap" "$CHOICE"
