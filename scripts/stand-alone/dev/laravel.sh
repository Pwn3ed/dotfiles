#!/bin/bash

echo "==> Checking for Laravel installation..."
if command -v laravel >/dev/null 2>&1; then
  echo "==> Laravel is already installed. Skipping installation."
else
  echo "==> Installing Laravel PHP setup..."
  /bin/bash -c "$(curl -fsSL https://php.new/install/linux/8.4)"
fi
