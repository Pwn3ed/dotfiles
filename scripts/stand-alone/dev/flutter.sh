#!/bin/bash

DEVELOPMENT_DIR="$HOME/.development"

# Create the development directory if it doesn't exist
mkdir -p "$DEVELOPMENT_DIR"

# Set Flutter version
FLUTTER_VERSION="3.32.8"  #Update this when needed!
FLUTTER_BASE_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux"

# Construct the download URL dynamically
FLUTTER_URL="${FLUTTER_BASE_URL}/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

# Check if Flutter is already installed
if ! command -v flutter &>/dev/null; then
  echo "==> Installing Flutter ${FLUTTER_VERSION}..."

  # Download Flutter
  wget -c "$FLUTTER_URL" -O "flutter_${FLUTTER_VERSION}_linux.tar.xz" || {
    echo "Error: Failed to download Flutter. Check your internet connection and try again."
    exit 1
  }

  # Extract Flutter
  tar -xf "flutter_${FLUTTER_VERSION}_linux.tar.xz" -C "$DEVELOPMENT_DIR" || {
    echo "Error: Failed to extract Flutter archive."
    exit 1
  }

  # Remove the archive
  rm "flutter_${FLUTTER_VERSION}_linux.tar.xz"

  echo "Flutter installed successfully. You may need to open a new terminal or source your shell configuration file."

  # yes | flutter doctor --android-licenses
else
  echo "Flutter is already installed."
fi
