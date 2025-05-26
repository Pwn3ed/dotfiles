#!/bin/bash

DIR="$HOME/dotfiles/scripts/wofi"

# Get list of files excluding menus.sh and strip .sh extension
FILES=($(ls "$DIR" | grep -v "^menus\.sh$" | sed 's/\.sh$//'))

# Build indexed menu
MENU="MENU LIST"
for i in "${!FILES[@]}"; do
    index=$((i + 1))
    MENU+="\n$index. ${FILES[$i]}"
done

# Show menu and capture selection
CHOICE=$(echo -e "$MENU" | wofi --dmenu --prompt "Menu List")

# Exit on cancel or if header selected
[ -z "$CHOICE" ] && exit
[[ "$CHOICE" == "MENU LIST" ]] && exit

# Extract the index from the selection
INDEX=$(echo "$CHOICE" | cut -d '.' -f 1)

# Map back to the original filename (add .sh back)
SCRIPT="${FILES[$((INDEX - 1))]}.sh"

# Execute the selected script
exec "$DIR/$SCRIPT"
