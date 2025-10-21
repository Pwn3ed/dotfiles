#!/bin/bash

sudo pacman -S gtk4 gtk4-layer-shell libadwaita blueprint-compiler gettext

git clone https://github.com/ghostty-org/ghostty

cd ghostty

zig build -Doptimize=ReleaseFast

# cd ..

# rm -rf ghostty
