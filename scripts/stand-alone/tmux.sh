#!/bin/bash

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm tmux

if [ -d "$HOME/.config/tmux/plugins/catppuccin/tmux" ]; then
  echo "Catppuccin theme is already installed. Skipping."
else
  git clone https://github.com/omerxx/catppuccin-tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi
