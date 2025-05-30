#!/bin/bash

# Check if the RUN_SCRIPT variable is set to true
if [ "$RUN_SCRIPT" != "true" ]; then
    echo "==> RUN_SCRIPT is not set to 'true'. Script will not run."
    exit 0
fi

echo "==> Updating Zsh config files..."
notify-send --app-name=Shell "Sync" "Updating shell files..."

SRC_DIR="$HOME/dotfiles/zsh"
DEST_FILE="$HOME/.zshrc"
DEST_DIR="$HOME/.zshrc.d"

if [ -f "$SRC_DIR/.zshrc" ]; then
    cp -f "$SRC_DIR/.zshrc" "$DEST_FILE"
    echo "==> .zshrc updated."
else
    echo "==> .zshrc not found in $SRC_DIR"
fi

if [ -d "$SRC_DIR/.zshrc.d" ]; then
    mkdir -p "$DEST_DIR"
    cp -rf "$SRC_DIR/.zshrc.d/"* "$DEST_DIR"
    echo "==> .zshrc.d/ updated."
else
    echo "==> .zshrc.d/ not found in $SRC_DIR"
fi
