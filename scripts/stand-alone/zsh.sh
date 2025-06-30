#!/bin/bash

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Check if oh-my-zsh is installed
if [ -d "$ZSH" ]; then
  # Check and install zsh-syntax-highlighting
  if [ -d "$ZSH/custom/plugins/zsh-syntax-highlighting" ]; then
    echo "zsh-syntax-highlighting already installed"
  else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH}/custom/plugins/zsh-syntax-highlighting"
  fi

  # Check and install zsh-autosuggestions
  if [ -d "$ZSH/custom/plugins/zsh-autosuggestions" ]; then
    echo "zsh-autosuggestions already installed"
  else
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH}/custom/plugins/zsh-autosuggestions"
  fi

  # === MOVE CONFIG FILES ===
  echo "==> Moving config files..."
  RUN_SCRIPT=true $HOME/dotfiles/scripts/update-zsh-files.sh
else
  echo "oh-my-zsh not installed!"
  exit 1
fi

# === ZSHRC PATH EXPORT ===
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi
