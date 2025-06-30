#!/bin/bash

yay -Suy --noconfirm
yay -S --needed --noconfirm mongodb-bin

if ! systemctl is-active --quiet mongodb; then
    echo "==> Starting MongoDB..."
    sudo chown -R mongodb:mongodb /var/lib/mongodb

    # Uncomment if needed
    # sudo chown mongodb:mongodb /tmp/mongodb-27017.sock

    sudo systemctl enable --now mongodb
else
    echo "==> MongoDB is already running. Skipping setup."
fi

