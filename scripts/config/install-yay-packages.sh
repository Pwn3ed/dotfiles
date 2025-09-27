# === AUR PACKAGES ===
yay_pkgs=(
  hyprland
  hyprpaper
  waybar
  wlogout-git
  neofetch
  opencode-bin # AI Agent
  dolphin # File Manager
  neovim-nightly-bin # File Editor (terminal based)
  # android-studio
  # geforcenow-electron # Geforce Now Interface
)

echo "==> Installing AUR packages..."
for pkg in "${yay_pkgs[@]}"; do
  if ! pacman -Qi "$pkg" &>/dev/null; then
    yay -S --noconfirm "$pkg"
  else
    echo "$pkg is already installed. Skipping."
  fi
done
