# === SYSTEM ESSENTIALS ===
essentials=(
  base-devel
  curl
  wget
  unzip
  ldns
  ufw
  networkmanager
  git
  libnotify
  mako
  man-db
  man-pages
)

# === SHELL & TERMINALS ===
terminals=(
  zsh
  alacritty
  tmux
  neofetch
  htop
)

# === UTILITIES ===
utilities=(
  github-cli
  bat
  fzf
  ripgrep
  wl-clipboard
  tldr
  xdg-desktop-portal-hyprland
  imagemagick
)

# === FONTS ===
fonts=(
  ttf-font-awesome
  ttf-nerd-fonts-symbols
  ttf-firacode-nerd
  ttf-jetbrains-mono-nerd
)

# === WINDOW MANAGER / DISPLAY ===
wm=(
  ly
  wofi
  # rofi-wayland
  hyprlock
  brightnessctl
  grim
  slurp
)

# === GRAPHICAL TOOLS ===
gui_apps=(
  ark
  firefox
  qutebrowser
  gimp
  pavucontrol
  obs-studio
  discord
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
  jdk17-openjdk
  maven
  rustup
  python
  python-pip
  python-virtualenv
  dotnet-sdk
  lua
  luarocks
  jq
  zig ## OUTDATED - v0.13 -> v0.14
)

# === DATABASES ===
databases=(
  mariadb
  postgresql
  sqlite
)

# === DEV TOOLS ===
dev_tools=(
  tree-sitter-cli
  tree
  love
  texlive
)

# === VIRTUALIZATION / CONTAINERS ===
virt=(
  docker
  docker-compose
  # virt-manager
  # qemu
  # libvirt
  # ebtables
  # dnsmasq
  # bridge-utils
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
