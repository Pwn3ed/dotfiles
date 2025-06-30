#!/bin/bash

# Check if the RUN_SCRIPT variable is set to true
if [ "$RUN_SCRIPT" != "true" ]; then
    echo "==> RUN_SCRIPT is not set to 'true'. Script will not run."
    exit 0
fi

SRC="$HOME/dotfiles/wallpapers/"
DEST="$HOME/wallpapers/"

echo "==> Moving Wallpapers..."
if [ -d "$SRC" ]; then
    # Create the destination directory if it doesn't exist
    mkdir -p "$DEST"

    cp -rf "$SRC"* "$DEST"

    echo "==> Wallpapers moved."
else
    echo "==> Wallpapers directory not found: $SRC."
fi
