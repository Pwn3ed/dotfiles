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
  file=$(fzf)
  [ -n "$file" ] && nvim "$file"
}

# nvim fzf --walker=dir
nvimfd() {
  local file
  file=$(fzf --walker=dir)
  [ -n "$file" ] && nvim "$file"
}

config-sync() {
  RUN_SCRIPT=${RUN_SCRIPT:-false} ~/dotfiles/scripts/update-config-files.sh
}

shell-sync() {
  RUN_SCRIPT=${RUN_SCRIPT:-false} ~/dotfiles/scripts/update-config-files.sh
}

config-compare() {
  ~/dotfiles/scripts/compare-config-files.sh
}

shell-compare() {
  ~/dotfiles/scripts/compare-zsh-files.sh
}
