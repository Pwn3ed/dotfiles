#!/bin/bash

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/sbin:/bin:$PATH"

DIR="$HOME/documents/screenshots"
mkdir -p "$DIR"

FILE=$(date +'screenshot_%Y-%m-%d-%H%M%S.png')
FULLPATH="$DIR/$FILE"

if [[ "$1" == "region" ]]; then
  slurp | grim -g - "$FULLPATH" && \
    wl-copy --type image/png < "$FULLPATH" && \
    notify-send --app-name=Screenshot "Region screenshot" "Saved and copied to clipboard: $FULLPATH"

elif [[ "$1" == "fullscreen" ]]; then
  grim "$FULLPATH" && \
    wl-copy --type image/png < "$FULLPATH" && \
    notify-send --app-name=Screenshot "Fullscreen screenshot" "Saved and copied to clipboard: $FULLPATH"

else
  echo "Usage: $0 [region|fullscreen]"
  exit 1
fi
