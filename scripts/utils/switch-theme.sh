#!/bin/bash
# switch-theme.sh
# Usage: ./switch-theme.sh light  OR  ./switch-theme.sh dark

set -e

THEME="$1"
THEME_DIR="$HOME/.config/themes/$THEME"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

if [[ -z "$THEME" ]]; then
    echo "Usage: $0 <light|dark>"
    exit 1
fi

if [[ ! -d "$THEME_DIR" ]]; then
    echo "Theme directory not found: $THEME_DIR"
    exit 1
fi

echo "Switching to theme: $THEME"

# Copy configs
cp "$THEME_DIR/fzf.zsh"     "$HOME/.zshrc.d/styles/fzf.zsh"
cp "$THEME_DIR/ghostty"     "$HOME/.config/ghostty/config"
cp "$THEME_DIR/mako"        "$HOME/.config/mako/config"
cp "$THEME_DIR/tmux.conf"   "$HOME/.config/tmux/tmux.conf"
cp "$THEME_DIR/waybar.css"  "$HOME/.config/waybar/style.css"
cp "$THEME_DIR/wofi.css"    "$HOME/.config/wofi/style.css"

# Reload/restart apps
if pgrep -x "waybar" >/dev/null; then
    killall -q waybar && waybar &
fi

if pgrep -x "mako" >/dev/null; then
    makoctl reload
fi

if [[ -n "$TMUX" ]]; then
    tmux source-file "$HOME/.config/tmux/tmux.conf"
fi

# Reload Zsh to apply fzf theme
source "$HOME/.zshrc"

# Set the correct wallpaper based on theme
if [[ "$THEME" == "light" ]]; then
    WALLPAPER="~/dotfiles/wallpapers/wallpaper12.jpg"
else
    WALLPAPER="~/dotfiles/wallpapers/wallpaper8.png"
fi

# Update the last line of the Hyprpaper config safely
if [[ -f "$HYPRPAPER_CONF" ]]; then
    sed -i "\$s|.*|wallpaper = ,$WALLPAPER|" "$HYPRPAPER_CONF"
fi

# Apply the wallpaper immediately
hyprctl hyprpaper wallpaper ",$WALLPAPER"

notify-send "Theme switched to $THEME" "Reload terminal to apply all changes."
echo "Reload terminal or reboot to apply all changes."
