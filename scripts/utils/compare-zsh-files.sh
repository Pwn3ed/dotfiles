#!/bin/bash

SRC_DIR="$HOME/dotfiles/zsh"
DEST_FILE="$HOME/.zshrc"
DEST_DIR="$HOME/.zshrc.d"

DIFF_FOUND=0

# Compare .zshrc files
if [ -f "$SRC_DIR/.zshrc" ]; then
    if [ -f "$DEST_FILE" ]; then
        if ! diff -q "$SRC_DIR/.zshrc" "$DEST_FILE" > /dev/null; then
            echo "==> .zshrc files differ."
            DIFF_FOUND=1
        fi
    else
        echo "==> Destination .zshrc file is missing."
        DIFF_FOUND=1
    fi
else
    echo "==> Source .zshrc file is missing."
fi

# Compare .zshrc.d directories
if [ -d "$SRC_DIR/.zshrc.d" ]; then
    if [ -d "$DEST_DIR" ]; then
        DIFF_OUTPUT=$(diff -qr "$SRC_DIR/.zshrc.d" "$DEST_DIR")
        if [ -n "$DIFF_OUTPUT" ]; then
            echo "==> Differences found in .zshrc.d:"
            echo "$DIFF_OUTPUT"
            DIFF_FOUND=1
        fi
    else
        echo "==> Destination .zshrc.d directory is missing."
        DIFF_FOUND=1
    fi
else
    echo "==> Source .zshrc.d directory is missing."
fi

if [ "$DIFF_FOUND" -eq 1 ]; then
    exit 0  # Differences found
else
    echo "==> Zsh config files are already in sync."
    exit 1  # No differences
fi

