#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm go

mkdir -p "$HOME/.development"

if [ -d "$HOME/go" ]; then
  mv "$HOME/go" "$HOME/.development/go"
else
  echo "No ~/go directory found to move"
fi
