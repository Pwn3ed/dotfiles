#!/bin/bash

SELECTED=$(ss -tuln | awk 'NR == 1 {print "Netid Port"; next} {split($5, a, ":"); print $1, a[length(a)]}' | wofi --dmenu --prompt "Ports: ")

PORT=$(echo "$SELECTED" | awk '{print $2}')

if [[ -n "$PORT" && "$PORT" =~ ^[0-9]+$ ]]; then
    INFO=$(ss -tulnp | grep ":$PORT\b")

    if [[ -n "$INFO" ]]; then
        FORMATTED=$(echo "$INFO" | awk '{print "Proto: " $1 "\nRecv-Q: " $2 "\nSend-Q: " $3 "\nLocal Address: " $5 "\nPeer Address: " $6 "\nProcess: " $7}')
    else
        FORMATTED="No detailed info found for port $PORT"
    fi

    notify-send --urgency=critical --app-name=Port "$PORT" "$FORMATTED"
    exit
fi

exec "$HOME/dotfiles/scripts/wofi/menus.sh"
