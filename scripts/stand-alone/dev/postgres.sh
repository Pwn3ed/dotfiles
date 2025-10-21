#!/bin/bash

# sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm postgresql

if ! systemctl is-active --quiet postgresql; then
    echo "==> Setting up PostgreSQL..."
    if [ ! -f /var/lib/postgres/data/PG_VERSION ]; then
        sudo -iu postgres initdb --locale "$LANG" -D /var/lib/postgres/data
    else
        echo "==> PostgreSQL data directory already initialized."
    fi
    sudo systemctl enable --now postgresql
else
    echo "==> PostgreSQL is already running. Skipping setup."
fi
