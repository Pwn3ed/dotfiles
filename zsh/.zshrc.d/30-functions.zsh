# Commands

# cd fzf
cdf() {
  cd
  dir=$(find . -type d -not -path '*/\.*' 2>/dev/null | fzf)
  [ -n "$dir" ] && cd "$dir"
}

# nvim fzf
nvimf() {
  local file
  file=$(fzf --preview='bat {}')
  [ -n "$file" ] && nvim "$file"
}

# nvim fzf --walker=dir
nvimfd() {
  local file
  file=$(fzf --walker=dir)
  [ -n "$file" ] && nvim "$file"
}

config-sync() {
  RUN_SCRIPT=${RUN_SCRIPT:-false} $HOME/dotfiles/scripts/update-config-files.sh
}

shell-sync() {
  RUN_SCRIPT=${RUN_SCRIPT:-false} $HOME/dotfiles/scripts/update-zsh-files.sh
}

config-compare() {
  $HOME/dotfiles/scripts/compare-config-files.sh
}

shell-compare() {
  $HOME/dotfiles/scripts/compare-zsh-files.sh
}

update-pacman() {
  if [[ "$1" == "-Syu" ]]; then
    echo "==> Updating system with pacman -Syu..."
    sudo pacman -Syu --noconfirm
  fi
  $HOME/dotfiles/scripts/install-pacman-packages.sh
}

update-yay() {
  if [[ "$1" == "-Suy" ]]; then
    echo "==> Updating system with yay -Suy..."
    yay -Suy --noconfirm
  fi
  $HOME/dotfiles/scripts/install-yay-packages.sh
}
