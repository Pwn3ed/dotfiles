## Dotfiles

* My arch enviroment config files;
* this README can be outdated so be careful;
* Work in progress, do not use this unless you know what you're doing;
* Fork this if you want to use it – I'll be pushing updates that might break things.

## DOWNLOAD SIZE:

- MINIMAL: ~6-8 GB
- FULL: ~12-28 GB
- LAST MEDIUM INSTALL: 6.1 GB
- LAST FULL INSTALL: 18 GB // i didn't installed -> unity, flutter, android-studio and virt-machine, so it should be around 25 GB

## FULL ENV SETUP

### connect to wifi

```sh

    iwctl
    device list
    station wlan0 show
    station wlan0 scan
    station wlan0 get-networks
    station wlan0 connect `YOUR_SSID`
    YOUR_WIFI_PASSWORD
    # ctrl+d to exit iwctl
    ping archlinux.org
    archinstall

```

* archinstall language: us
* keyboard input: br-abnt2
* mirror region: \[brazil\]
* disk: partition > ext4 no /home partition
* bootloader: grub
* swap: true
* hostname: archlinux
* root password: `YOUR_ROOT_PASSWORD`, `CONFIRM_ROOT_PASSWORD`
* new user account: `YOUR_USERNAME`, `YOUR_PASSWORD`, `CONFIRM_YOUR_PASSWORD`, sudo user: true
* profile: minimal
* audio: pipewire
* packages: git curl vim
* network: networkmanager
* timezone: America/Sao_Paulo
* time sync: true
* `install`
* chroot -> no
* `reboot`

### login & setup

```sh

    login: YOUR_USERNAME
    Password: YOUR_PASSWORD

    nmcli device wifi connect YOUR_WIFI_SSDID password YOUR_WIFI_PASSWORD

    git clone https://github.com/leonardo-luz/dotfiles.git

    chmod +x $HOME/dotfiles/scripts/install-pacman-packages.sh
    chmod +x $HOME/dotfiles/scripts/install-yay-packages.sh

    chmod +x $HOME/dotfiles/scripts/setup-arch-env.sh
    chmod +x $HOME/dotfiles/scripts/setup-zsh-plugins.sh

    chmod +x $HOME/dotfiles/scripts/update-config-files.sh
    chmod +x $HOME/dotfiles/scripts/update-zsh-files.sh

    chmod +x $HOME/dotfiles/scripts/compare-config-files.sh
    chmod +x $HOME/dotfiles/scripts/compare-zsh-files.sh

    vim setup-arch-env.sh # remove or add the packages that want

     # this will overwrite some config files from .config so backup those before, if you want
    ./setup-arch-env.sh # if you need to rerun this script again, reboot your system before

    sudo vim /etc/libvirt/libvirtd.conf # Uncomment: unix_sock_group, if libvirt was installed
    sudo vim /usr/share/wayland-sessions/hyprland.desktop # replace by the content in ~/dotfiles/ly/hyprland.desktop
    sudo vim /etc/ly/config.ini # replace by the content in ~/dotfiles/ly/config.ini"

    sudo mysql_secure_installation # will change to mariadb_secure_installation

    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # accept the change to zsh

    # You will probably need to reboot here

     # this will remove your zsh config so backup it before if you want
    ./setup-zsh-plugins.sh

    reboot

```
