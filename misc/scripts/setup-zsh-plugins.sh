#!/bin/bash

# Check if oh-my-zsh is installed
if [ -z "$ZSH_CUSTOM" ]; then
  echo "oh-my-zsh not installed!"
  exit 1
fi

# Check and install zsh-syntax-highlighting
if [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "zsh-syntax-highlighting already installed"
else
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi

# Check and install zsh-autosuggestions
if [ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "zsh-autosuggestions already installed"
else
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
fi

echo "In ~/.zshrc change ZSH_THEME to 'bureau'"
echo "In ~/.zshrc add 'zsh-autosuggestions zsh-syntax-highlighting' to plugins"
