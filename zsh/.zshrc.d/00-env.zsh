# Path to bin
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.cargo/bin:$PATH

# Path to flutter
export PATH=$HOME/.development/flutter/bin:$PATH

# Path to go
export GOPATH="$HOME/.development/go"
export PATH="$GOPATH/bin:$PATH"

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

# Enable safer history behavior
setopt HIST_VERIFY
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE

# Default editor
export EDITOR="nvim"

export GPG_TTY=$(tty)

export TMUX_THEME="light"

# set rust env_logger crate to info
export RUST_LOG="info"

# Open man with nvim
export MANPAGER="nvim +Man!"
