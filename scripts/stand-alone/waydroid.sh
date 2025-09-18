#!/bin/bash
#
# https://wiki.archlinux.org/title/Waydroid

yay -S waydroid

## Kernel config
# sudo modprobe binder_linux
# sudo modprobe ashmem_linux
# sudo mkdir -p /dev/binderfs
# sudo mount -t binder binder /dev/binderfs
# 
# binder /dev/binderfs binder defaults 0 0

waydroid init -s GAPPS

sudo systemclt start waydroid-container.service
sudo systemclt enable waydroid-container.service
