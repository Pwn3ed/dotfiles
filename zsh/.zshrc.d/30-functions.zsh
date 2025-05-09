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
