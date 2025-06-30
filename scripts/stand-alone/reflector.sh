#!/bin/bash

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm reflector

# Move reflector configuration
SRC="$HOME/dotfiles/etc/xdg/reflector/reflector.conf"
DEST="/etc/xdg/reflector/reflector.conf"

# Check if the source file exists
if [ ! -f "$SRC" ]; then
  echo "Error: Source file '$SRC' does not exist."
  exit 1
fi

# Create the destination directory if it doesn't exist
mkdir -p "$(dirname "$DEST")" || {
  echo "Error: Could not create directory '$(dirname "$DEST")'."
  exit 1
}

# Move the file using sudo, replacing if it exists
sudo mv "$SRC" "$DEST" || {
  echo "Error: Could not move file '$SRC' to '$DEST'. Check permissions."
  exit 1
}

sudo systemctl start reflector.service
sudo systemctl enable reflector.timer
