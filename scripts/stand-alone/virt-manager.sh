#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm qemu-full qemu-emulators-full virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libguestfs libvirt

sudo systemctl enable --now libvirtd

sudo sed -i -E "s|^\s*#?\s*unix_sock_group\s*=.*|unix_sock_group = 'libvirt'|" /etc/libvirt/libvirtd.conf
sudo sed -i -E "s|^\s*#?\s*unix_sock_rw_perms\s*=.*|unix_sock_rw_perms = '0770'|" /etc/libvirt/libvirtd.conf

if ! grep -q "^unix_sock_group" /etc/libvirt/libvirtd.conf; then
    echo "unix_sock_group = 'libvirt'" | sudo tee -a /etc/libvirt/libvirtd.conf
fi

if ! grep -q "^unix_sock_rw_perms" /etc/libvirt/libvirtd.conf; then
    echo "unix_sock_rw_perms = '0770'" | sudo tee -a /etc/libvirt/libvirtd.conf
fi

user=${SUDO_USER:-$USER}
sudo usermod -aG libvirt,kvm "$user" || { echo "Error adding user to libvirt and kvm groups."; exit 1; }

sudo systemctl restart libvirtd.service || { echo "Error restarting libvirtd service."; exit 1; }

echo "Please log out and log back in (or reboot) to apply group changes."
