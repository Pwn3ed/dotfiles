#!/bin/bash

## WARN: DOWNLOAD SIZE:
## MINIMAL: ~6-8 GB
## FULL: ~12-24 GB
## LAST MEDIUM INSTALL: 6.1 GB
## LAST FULL INSTALL: ~20 GB

packages=(
  github-cli
  curl
  tldr
  fzf
  wl-clipboard
  unzip
  base-devel
  ripgrep
  ark
  ly
  alacritty
  wezterm
  zsh
  wofi
  rofi-wayland
  ldns
  ufw
  NetworkManager
  firefox
  gimp
  tlp
  tlp-rdw
  pavucontrol
  tmux
  neofetch
  htop
  zathura
  zathura-pdf-mupdf
  grim
  slurp
  obs-studio
  obsidian
  ttf-font-awesome
  ttf-firacode-nerd
  mariadb
  postgresql
  love
  latexmk
  texlive-most
  gcc
  gdb
  make
  cmake
  jdk-openjdk
  maven
  nodejs
  npm
  go
  python
  python-pip
  python-virtualenv
  dotnet-sdk
  luarocks
  lua
  tree-sitter
  docker
  docker-compose
  rustup
  virt-manager
  qemu
  libvirt
  ebtables
  dnsmasq
  bridge-utils
  git
)

yay=(
  hyprland
  hyprpaper
  waybar
  dolphin
  nerd-fonts-fira-code
  mongodb-bin
  unityhub
  android-studio
  flutter
  neovim-nightly-bin
)

# UPDATE SYSTEM PACKAGES
sudo pacman -Syu --noconfirm

# INSTALL YAY
ISYAY=/sbin/yay
if [ -f "$ISYAY" ]; then 
  echo "yay is already installed."
  yay -Suy --noconfirm
else
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin || exit
  makepkg -si --noconfirm
  yay -Suy --noconfirm
  cd ..
  rm -rf yay-bin
fi

# MOVE CONFIG FILES
SRC="$HOME/dotfiles/.config/"
DEST="$HOME/.config/"
mkdir -p "$DEST"
mv -f "$SRC"* "$DEST"

# INSTALL PROCESS

# Install pacman packages
sudo pacman -S --needed "${packages[@]}"

# Install using yay without reinstalling existing ones
for pkg in "${yay[@]}"; do
  if ! pacman -Qi "$pkg" &>/dev/null; then
    yay -S --noconfirm "$pkg"
  else
    echo "$pkg is already installed. Skipping."
  fi
done

/bin/bash -c "$(curl -fsSL https://php.new/install/linux/8.4)" # LARAVEL
chsh -s $(which zsh) # CHANGE TO ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # OH MY ZSH

# CONFIG INSTALLED SERVICES
# TLP CONFIG
sudo systemctl enable tlp
sudo systemctl start tlp

# MARIA DB CONFIG
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable mariadb
sudo systemctl start mariadb
sudo mysql_secure_installation

# POSTGRESQL CONFIG
sudo -iu postgres initdb --locale $LANG -D /var/lib/postgres/data
sudo systemctl enable postgresql
sudo systemctl start postgresql

# MONGODB CONFIG
sudo chown -R mongodb:mongodb /var/lib/mongodb
sudo chown mongodb:mongodb /tmp/mongodb-27017.sock
sudo systemctl enable mongodb
sudo systemctl start mongodb

# LY CONFIG
sudo systemctl enable ly.service

# DOCKER CONFIG
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# VIRT-MACHINE CONFIG
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
sudo usermod -aG libvirt,kvm $USER

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi

echo
echo "Installation completed!"

echo
echo "TO DO!"
echo "Go to /etc/libvirt/libvirtd.conf and uncomment unix_sock_group in line 86"
echo "Go to /usr/share/wayland-sessions/hyprland.desktop and change the data inside it by the one in ~/dotfiles/misc/ly/hyprland.desktop"
echo "Go to /etc/ly/config.ini and change the data inside it by the one in ~/dotfiles/misc/ly/config.ini""
