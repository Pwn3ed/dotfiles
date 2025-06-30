#!/bin/bash

SRC="$HOME/dotfiles/.config/"
DEST="$HOME/.config/"

# Compare file contents recursively
DIFF_OUTPUT=$(diff -qr "$SRC" "$DEST" | grep -v "^Only in")

if [ -n "$DIFF_OUTPUT" ]; then
    echo "==> Differences detected:"
    echo "$DIFF_OUTPUT"
    exit 0  # Differences found
else
    echo "==> No content differences found between $SRC and $DEST."
    exit 1  # No sync needed
fi
