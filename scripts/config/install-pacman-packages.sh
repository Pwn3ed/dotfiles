# === SYSTEM ESSENTIALS ===
essentials=(
  base-devel
  curl
  wget
  unzip
  fd
  git
  libnotify
  mako
  man-db
  man-pages
  libva-utils
  # iptables-nft # Conflict
  intel-media-driver # intel gpu
  pacman-contrib
)

# === UTILITIES ===
utilities=(
  # neofetch # FIX: Not found
  htop # service manager
  github-cli # gh
  bat # file viewer
  fzf # fuzy finder
  ripgrep # grep
  wl-clipboard # clipboard integration
  tldr
  xdg-desktop-portal-hyprland
  imagemagick # image render on terminal
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
  python
  python-pip
  python-virtualenv
  dotnet-sdk
  lua
  luarocks
  jq
  zig ## OUTDATED - v0.13 -> v0.14 (use AUR ?)
)

# === DATABASES ===
databases=(
  sqlite
)

# === DEV TOOLS ===
dev_tools=(
  jenkins
  tree-sitter-cli
  tree
  love
)

# INSTALL ALL PACMAN PACKAGES
all_pacman_pkgs=(
  "${essentials[@]}"
  "${utilities[@]}"
  "${fonts[@]}"
  "${wm[@]}"
  "${gui_apps[@]}"
  "${power[@]}"
  "${docs[@]}"
  "${dev_langs[@]}"
  "${databases[@]}"
  "${dev_tools[@]}"
)

echo "==> Installing packages via pacman..."
sudo pacman -S --needed --noconfirm "${all_pacman_pkgs[@]}"
