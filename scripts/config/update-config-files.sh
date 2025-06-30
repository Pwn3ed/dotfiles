#!/bin/bash

# Check if the RUN_SCRIPT variable is set to true
if [ "$RUN_SCRIPT" != "true" ]; then
  echo "==> RUN_SCRIPT is not set to 'true'. Script will not run."
  exit 0
fi

echo "==> Updating config files..."
notify-send --app-name=Config "Sync" "Updating config files..."

SRC="$HOME/dotfiles/.config/"
DEST="$HOME/.config/"

if [ -d "$SRC" ]; then
    # Create the destination directory if it doesn't exist
    mkdir -p "$DEST"

    # Copy all files and subdirectories recursively
    cp -rf "$SRC"* "$DEST"

    echo "==> Config files moved to $DEST."
else
    echo "==> Source config directory not found: $SRC."
fi
