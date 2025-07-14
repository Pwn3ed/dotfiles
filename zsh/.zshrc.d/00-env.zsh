# Path to bin
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.cargo/bin:$PATH

# Path to java JDK
# export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export JAVA_HOME=/usr/lib/jvm/java-24-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# Remove maven warnings
export MAVEN_OPTS="--enable-native-access=ALL-UNNAMED"

export DOTNET_ROOT=/usr/share/dotnet

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Firefox options
export MOZ_ENABLE_WAYLAND=1
export MOZ_X11_EGL=1

# Fuzy finder options
export FZF_DEFAULT_OPTS="
  --height=40%
  --layout=reverse
  --preview-window=right:60%
  --color=fg:#d0d0d0,bg:#1e1e1e,preview-bg:#1e1e1e,hl:#ff9d00,fg+:#ffffff,bg+:#5f5f5f,hl+:#ffaa00
"

# Enable safer history behavior
setopt HIST_VERIFY
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE

# Default editor
export EDITOR="nvim"
