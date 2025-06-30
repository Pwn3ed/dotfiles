#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm mariadb

# === MariaDB ===
if ! systemctl is-active --quiet mariadb; then
    echo "==> Installing and starting MariaDB..."
    sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    sudo systemctl enable --now mariadb
else
    echo "==> MariaDB is already running. Skipping setup."
fi

sudo mysql_secure_installation # WARN: will change to mariadb_secure_installation
