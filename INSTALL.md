## INSTALL SIZE: ~30 GB

## INSTALL GUIDE

### [INSTALL ARCH](./ARCHINSTALL.md)

### SETUP SYSTEM (from clean arch install)

```sh

    # Connect to wifi using network manager
    nmcli device wifi connect YOUR_WIFI_SSDID password YOUR_WIFI_PASSWORD

    # Clone this repository in the home directory
    cd # Goes to the home dir
    git clone https://github.com/leonardo-luz/dotfiles.git

    # Edit the packages you want to install
    vim ~/dotfiles/scripts/install-pacman-packages.sh
    vim ~/dotfiles/scripts/install-yay-packages.sh

    # This will overwrite some config files from .config so backup those before, if you want
    # If you need to rerun this script, reboot your system before doing it
    ~/dotfiles/scripts/setup-arch-env.sh

    sudo vim /etc/libvirt/libvirtd.conf # Uncomment: unix_sock_group, if libvirt was installed
    sudo vim /usr/share/wayland-sessions/hyprland.desktop # replace by the content in ~/dotfiles/ly/hyprland.desktop
    sudo vim /etc/ly/config.ini # replace by the content in ~/dotfiles/ly/config.ini"
    sudo vim /etc/xdg/reflector/reflector.conf # replace by the content in ~/dotfiles/etc/xdg/reflector/reflector.conf"

    sudo mysql_secure_installation # will change to mariadb_secure_installation

    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # You will probably need to reboot here

    # this will remove your zsh config so backup it before if you want
    ~/dotfiles/scripts/setup-zsh-plugins.sh

    # [OPTIONAL] update mirrors weekly
    sudo systemctl enable reflector.timer
    sudo systemctl start reflector.timer

    reboot

```
