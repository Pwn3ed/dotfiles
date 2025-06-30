#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm docker docker-compose

# Enable docker service
sudo systemctl enable --now docker

# Add user to docker
sudo usermod -aG docker "$USER"
