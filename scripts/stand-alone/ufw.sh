#!/bin/bash

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm ufw ldns

sudo systemctl start ufw.service
sudo systemctl enable ufw.service

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw enable
