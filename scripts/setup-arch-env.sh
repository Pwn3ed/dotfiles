#!/bin/bash

set -e

echo "==> Updating system..."
sudo pacman -Syu --noconfirm

echo "==> Installing yay..."
"$HOME/dotfiles/scripts/stand-alone/yay.sh"

echo "==> Installing basic pacman packages..."
"$HOME/dotfiles/scripts/config/install-pacman-packages.sh"

echo "==> Installing basic yay packages..."
"$HOME/dotfiles/scripts/config/install-yay-packages.sh"

echo "==> Creating documents (~/documents) directory"
mkdir -p "$HOME/documents"

echo "==> Creating screenshots (~/documents/screenshots) directory"
mkdir -p "$HOME/documents/screenshots"

echo "==> Creating development tools (~/.development) directory"
mkdir -p "$HOME/.development"

echo "==> Moving config files..."
RUN_SCRIPT=true "$HOME/dotfiles/scripts/config/update-config-files.sh"

echo "==> Enabling system services..."

sudo systemctl enable --now tlp # enable batery saver
sudo systemctl enable ly.service # enable display manager

echo "==> Installing and Configuring Network Manager"
"$HOME/dotfiles/scripts/stand-alone/network.sh"

echo "==> Installing and Configuring Reflector"
"$HOME/dotfiles/scripts/stand-alone/reflector.sh"

echo "==> Installing and Configuring uncomplicated firewall (ufw)"
"$HOME/dotfiles/scripts/stand-alone/ufw.sh"

echo "==> Installing terminal"
"$HOME/dotfiles/scripts/stand-alone/terminal.sh"

echo "==> Installing and Configuring tmux"
"$HOME/dotfiles/scripts/stand-alone/tmux.sh"

echo "==> Installing and Configuring zshell (zsh)"
"$HOME/dotfiles/scripts/stand-alone/zsh.sh"

# === TO-DO REMINDERS ===
echo
echo "Installation completed!"
echo
echo "Check the ~/dotfiles/scripts/stand-alone directory for more applications"
echo "Read the README before using your system!!!"
