#!/bin/bash

yay -Suy --noconfirm
yay -S --noconfirm unityhub

mkdir -p "$HOME/.development/tmp"

echo "Set the unity tmp dir to $HOME/.development/tmp"
