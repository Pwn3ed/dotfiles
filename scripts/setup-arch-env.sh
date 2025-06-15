#!/bin/bash

## TODO:
#  ADD raylib, javafx, [? nm-applet, nwg-look, qt6ct ?]

# Exit on error
set -e

echo "==> Updating system..."
sudo pacman -Syu --noconfirm

echo "==> Installing yay..."
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

## Installing pacman packages
$HOME/dotfiles/scripts/install-pacman-packages.sh

## Installing yay packages
$HOME/dotfiles/scripts/install-yay-packages.sh

# Set Rust stable as default
if command -v rustup >/dev/null 2>&1; then
    echo "==> Setting Rust stable as default..."
    rustup default stable
else
    echo "==> rustup not found. Skipping Rust setup."
fi

mkdir -p "$HOME/documents/screenshots"

# === MOVE CONFIG FILES ===
echo "==> Moving config files..."
RUN_SCRIPT=true $HOME/dotfiles/scripts/update-config-files.sh

RUN_SCRIPT=true $HOME/dotfiles/scripts/update-wallpapers-files.sh

if [ -d "$HOME/.config/tmux/plugins/catppuccin/tmux" ]; then
  echo "Catppuccin theme is already installed. Skipping."
else
  git clone https://github.com/omerxx/catppuccin-tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi

# === LARAVEL INSTALLER ===
echo "==> Checking for Laravel installation..."
if command -v laravel >/dev/null 2>&1; then
  echo "==> Laravel is already installed. Skipping installation."
else
  echo "==> Installing Laravel PHP setup..."
  /bin/bash -c "$(curl -fsSL https://php.new/install/linux/8.4)"
fi

# === ENABLE SERVICES ===
echo "==> Enabling system services..."

sudo systemctl enable --now tlp
sudo systemctl enable --now docker
# sudo systemctl enable --now libvirtd
sudo systemctl enable ly.service
sudo systemctl enable ufw.service

# === POST-INSTALL DB SETUP ===
echo "==> Configuring databases..."

# === MariaDB ===
if ! systemctl is-active --quiet mariadb; then
    echo "==> Installing and starting MariaDB..."
    sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    sudo systemctl enable --now mariadb
else
    echo "==> MariaDB is already running. Skipping setup."
fi

# === PostgreSQL ===
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

# === MongoDB ===
if ! systemctl is-active --quiet mongodb; then
    echo "==> Starting MongoDB..."
    sudo chown -R mongodb:mongodb /var/lib/mongodb
    # Uncomment if needed
    # sudo chown mongodb:mongodb /tmp/mongodb-27017.sock
    sudo systemctl enable --now mongodb
else
    echo "==> MongoDB is already running. Skipping setup."
fi


# === USER GROUP SETUP ===
echo "==> Adding user to docker and libvirt groups..."
# sudo usermod -aG libvirt "$USER"
# sudo usermod -aG kvm "$USER"
sudo usermod -aG docker "$USER"

# === ZSHRC PATH EXPORT ===
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi

# === TO-DO REMINDERS ===
echo
echo "Installation completed!"
echo
echo "Read the README before using your system!!!"
