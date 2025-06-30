#!/bin/bash

## TODO:
#  ADD raylib, javafx, [? nm-applet, nwg-look, qt6ct ?]

# Exit on error
set -e

echo "==> Updating system..."
sudo pacman -Syu --noconfirm

echo "==> Installing yay..."
if ! command -v yay &>/dev/null; then
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin || exit
  makepkg -si --noconfirm
  cd ..
  rm -rf yay-bin

  yay -Suy --noconfirm
else
  yay -Suy --noconfirm
fi

## Installing pacman packages
exec $HOME/dotfiles/scripts/config/install-pacman-packages.sh

## Installing yay packages
exec $HOME/dotfiles/scripts/config/install-yay-packages.sh

## Creating screenshots dir
mkdir -p "$HOME/documents/screenshots"

echo "==> Moving config files..."
exec RUN_SCRIPT=true $HOME/dotfiles/scripts/config/update-config-files.sh

echo "==> Enabling system services..."

sudo systemctl enable --now tlp # enable batery saver
sudo systemctl enable ly.service # enable display manager
sudo systemctl enable ufw.service # enables firewall

# === TO-DO REMINDERS ===
echo
echo "Installation completed!"
echo
echo "Read the README before using your system!!!"
