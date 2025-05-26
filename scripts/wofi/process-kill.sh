#!/bin/bash

PID=$(ps -e -o pid,comm --sort=-%mem | wofi --dmenu --prompt "Kill which process?" | awk '{print $1}')


if [[ -n "$PID" && "$PID" =~ ^[0-9]+$ ]]; then
    notify-send --app-name=Process-Kill "Stopping process $PID"
    kill "$PID"
    exit
fi

exec "$HOME/dotfiles/scripts/wofi/menus.sh"
