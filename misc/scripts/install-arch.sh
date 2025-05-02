#!/bin/bash

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
else
  yay -Suy --noconfirm
fi

# === SYSTEM ESSENTIALS ===
essentials=(
  base-devel
  curl
  unzip
  ldns
  ufw
  NetworkManager
  git
)

# === SHELL & TERMINALS ===
terminals=(
  zsh
  alacritty
  # wezterm
  tmux
  neofetch
  htop
)

# === UTILITIES ===
utilities=(
  github-cli
  fzf
  wl-clipboard
  tldr
)

# === FONTS ===
fonts=(
  ttf-font-awesome
  ttf-firacode-nerd
)

# === WINDOW MANAGER / DISPLAY ===
wm=(
  ly
  wofi
  # rofi-wayland
  grim
  slurp
)

# === GRAPHICAL TOOLS ===
gui_apps=(
  ark
  firefox
  gimp
  pavucontrol
  obs-studio
  obsidian
)

# === BATTERY/POWER ===
power=(
  tlp
  tlp-rdw
)

# === DOCUMENT TOOLS ===
docs=(
  zathura
  zathura-pdf-mupdf
)

# === DEV LANGUAGES & COMPILERS ===
dev_langs=(
  gcc
  gdb
  make
  cmake
  go
  nodejs
  npm
  jdk-openjdk
  maven
  rustup
  python
  python-pip
  python-virtualenv
  dotnet-sdk
  lua
  luarocks
)

# === DATABASES ===
databases=(
  mariadb
  postgresql
  mongodb-bin
)

# === DEV TOOLS ===
dev_tools=(
  tree-sitter
  love
  latexmk
  texlive-most
)

# === VIRTUALIZATION / CONTAINERS ===
virt=(
  docker
  docker-compose
  virt-manager
  qemu
  libvirt
  ebtables
  dnsmasq
  bridge-utils
)

# INSTALL ALL PACMAN PACKAGES
all_pacman_pkgs=(
  "${essentials[@]}"
  "${terminals[@]}"
  "${utilities[@]}"
  "${fonts[@]}"
  "${wm[@]}"
  "${gui_apps[@]}"
  "${power[@]}"
  "${docs[@]}"
  "${dev_langs[@]}"
  "${databases[@]}"
  "${dev_tools[@]}"
  "${virt[@]}"
)

echo "==> Installing packages via pacman..."
sudo pacman -S --needed --noconfirm "${all_pacman_pkgs[@]}"

# Set Rust stable as default
rustup default stable

# Install rust-analyzer
rustup component add rust-analyzer

# === AUR PACKAGES ===
yay_pkgs=(
  hyprland
  hyprpaper
  waybar
  dolphin
  nerd-fonts-fira-code
  unityhub
  android-studio
  flutter
  neovim-nightly-bin
)

echo "==> Installing AUR packages..."
for pkg in "${yay_pkgs[@]}"; do
  if ! pacman -Qi "$pkg" &>/dev/null; then
    yay -S --noconfirm "$pkg"
  else
    echo "$pkg is already installed. Skipping."
  fi
done

# === MOVE CONFIG FILES ===
echo "==> Moving config files..."
SRC="$HOME/dotfiles/.config/"
DEST="$HOME/.config/"
mkdir -p "$DEST"
mv -f "$SRC"* "$DEST"

# === LARAVEL INSTALLER ===
echo "==> Installing Laravel PHP setup..."
/bin/bash -c "$(curl -fsSL https://php.new/install/linux/8.4)"

# === ENABLE SERVICES ===
echo "==> Enabling system services..."

sudo systemctl enable --now tlp
sudo systemctl enable --now mariadb
sudo systemctl enable --now postgresql
sudo systemctl enable --now docker
sudo systemctl enable --now libvirtd
sudo systemctl enable --now ly.service

# === POST-INSTALL DB SETUP ===
echo "==> Configuring databases..."

# MariaDB
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# PostgreSQL
sudo -iu postgres initdb --locale "$LANG" -D /var/lib/postgres/data

# MongoDB
sudo chown -R mongodb:mongodb /var/lib/mongodb
sudo chown mongodb:mongodb /tmp/mongodb-27017.sock
sudo systemctl enable --now mongodb

# === USER GROUP SETUP ===
echo "==> Adding user to docker and libvirt groups..."
sudo usermod -aG libvirt, kvm, docker  "$USER"

# === ZSHRC PATH EXPORT ===
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi

# === TO-DO REMINDERS ===
echo
echo "Installation completed!"
echo
echo "TO DO:"
echo "1. Edit /etc/libvirt/libvirtd.conf → Uncomment: unix_sock_group"
echo "2. Update /usr/share/wayland-sessions/hyprland.desktop → Use ~/dotfiles/misc/ly/hyprland.desktop"
echo "3. Update /etc/ly/config.ini → Use ~/dotfiles/misc/ly/config.ini"
echo "4. Run the following commands and follow their instructions: "
echo "   sudo mysql_secure_installation"
echo "   chsh -s \$(which zsh)"
echo '   sh -c "\$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
echo "5. reboot"
