#!/bin/bash

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
