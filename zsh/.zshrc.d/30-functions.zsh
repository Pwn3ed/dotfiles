# Commands

# cd fzf
cdf() {
  dir=$(fd --type d --hidden --exclude .git --exclude node_modules | fzf)
  [ -n "$dir" ] && cd "$dir"
}

hist() {
  local cmd
  unsetopt HIST_VERIFY
  unsetopt HIST_SAVE_NO_DUPS

  cmd=$(history | awk '{$1=""; sub(/^ /, ""); print}' | fzf)

  if [[ -n "$cmd" ]]; then
    eval " $cmd"
  fi

  setopt HIST_VERIFY
  setopt HIST_SAVE_NO_DUPS
}

# nvim fzf
nvimf() {
  local file
  file=$(fd --hidden --exclude .git --exclude node_modules | fzf --preview='bat --style=numbers --color=always --line-range :300 {}')
  [ -n "$file" ] && nvim "$file"
}

# nvim fzf --walker=dir
nvimfd() {
  local file
  file=$(fzf --walker=dir)
  [ -n "$file" ] && nvim "$file"
}

config-sync() {
  RUN_SCRIPT=${RUN_SCRIPT:-false} $HOME/dotfiles/scripts/config/update-config-files.sh
}

shell-sync() {
  RUN_SCRIPT=${RUN_SCRIPT:-false} $HOME/dotfiles/scripts/config/update-zsh-files.sh
}

config-compare() {
  $HOME/dotfiles/scripts/utils/compare-config-files.sh
}

shell-compare() {
  $HOME/dotfiles/scripts/utils/compare-zsh-files.sh
}

switch-theme() {
  $HOME/dotfiles/scripts/utils/switch-theme.sh $1
}

update-pacman() {
  if [[ "$1" == "-Syu" ]]; then
    echo "==> Updating system with pacman -Syu..."
    sudo pacman -Syu --noconfirm
  fi
  $HOME/dotfiles/scripts/config/install-pacman-packages.sh
}

update-yay() {
  if [[ "$1" == "-Suy" ]]; then
    echo "==> Updating system with yay -Suy..."
    yay -Suy --noconfirm
  fi
  $HOME/dotfiles/scripts/config/install-yay-packages.sh
}
