#!/bin/bash

if [ "$1" == "toggle" ]; then
    playerctl play-pause
    exit 0
fi

if ! playerctl status &> /dev/null; then
    exit 0
fi

STATUS=$(playerctl status)
TITLE=$(playerctl metadata title 2>/dev/null)
ARTIST=$(playerctl metadata artist 2>/dev/null)

[ -z "$TITLE" ] && TITLE="Unknown Title"
[ -z "$ARTIST" ] && DISPLAY_TITLE="$TITLE" || DISPLAY_TITLE="$ARTIST - $TITLE"

MAX_LENGTH=40
if [ ${#DISPLAY_TITLE} -gt $MAX_LENGTH ]; then
    DISPLAY_TITLE="${DISPLAY_TITLE:0:$((MAX_LENGTH-1))}…"
fi

case "$STATUS" in
    "Playing")
        echo "$DISPLAY_TITLE "
        ;;
    "Paused")
        echo "$DISPLAY_TITLE "
        ;;
esac
