#!/bin/bash

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm virt-manager qemu libvirt ebtables dnsmasq bridge-utils

sudo systemctl enable --now libvirtd

sudo usermod -aG libvirt "$USER"
sudo usermod -aG kvm "$USER"
