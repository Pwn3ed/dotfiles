# Main Zsh configuration file
export ZSHRC_DIR="$HOME/.zshrc.d"

# Source all modules
for file in $ZSHRC_DIR/*.zsh; do
  source "$file"
done
