## Dotfiles

* My arch enviroment config files;
* Work in progress, do not use this unless you know what you're doing;

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
    ping 8.8.8.8
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

    mv ~/dotfiles/misc/scripts/setup-arch-env.sh ~/
    chmod +x setup-arch-env.sh
    vim setup-arch-env.sh # remove or add the packages that want
    ./setup-arch-env.sh # if you need to rerun this script again, reboot your system before

    mv ~/dotfiles/misc/scripts/setup-zsh-plugins.sh ~/
    chmod +x setup-zsh-plugins.sh


    sudo vim /etc/libvirt/libvirtd.conf # Uncomment: unix_sock_group
    sudo vim /usr/share/wayland-sessions/hyprland.desktop # replace by the content in ~/dotfiles/misc/ly/hyprland.desktop
    sudo vim /etc/ly/config.ini # replace by the content in ~/dotfiles/misc/ly/config.ini"

    sudo mariadb_secure_installation

    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # accept the change to zsh

    # You will probably need to reboot here

    ./setup-zsh-plugins.sh
    sudo vim ~/.zshrc # In your zshrc do:
    # ZSH_THEME="bureau"
    # plugins=('git zsh-autosuggestions zsh-syntax-highlighting')
    # export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
    # export PATH=$JAVA_HOME/bin:$PATH

    rm -rf ~/dotfiles
    rm ~/setup-arch-env.sh
    rm ~/setup-zsh-plugins.sh

    reboot

```
