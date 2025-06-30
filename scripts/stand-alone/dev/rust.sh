#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm rustup

# Set Rust stable as default
if command -v rustup >/dev/null 2>&1; then
    echo "==> Setting Rust stable as default..."
    rustup default stable
else
    echo "==> rustup not found. Skipping Rust setup."
fi

