#!/bin/bash

sudo pacman -Syu --noconfirm
yay -Suy --noconfirm

echo "Choose your terminal: [1] ghostty (default) [2] alacritty [3] wezterm"
read -r -p "Enter your choice (or press Enter for ghostty): " input

case "$input" in
  "yes"|"y"|""|1)
    yay -S --needed --noconfirm ghostty-git
    ;;
  2)
    sudo pacman -S --needed --noconfirm alacritty
    ;;
  3)
    yay -S --needed --noconfirm wezterm-git
    ;;
  *)
    echo "Invalid option. Please choose 1, 2, or 3."
    exit 1
    ;;
esac
