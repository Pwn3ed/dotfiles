#!/bin/bash

yay -Suy --noconfirm
yay -S --noconfirm unityhub

mkdir -p "$HOME/.development/tmp/unityhub"

mv "$HOME/Unity" "$HOME/.development"
ln -s "$HOME/.development/Unity" "$HOME/Unity"

echo "Set the unity tmp dir to $HOME/.development/tmp"
