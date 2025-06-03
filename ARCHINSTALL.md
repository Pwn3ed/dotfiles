## Minimal ARCHINSTALL step-by-step

```sh

    # wifi connection [skip if using ethernet]
    iwctl
    device list
    station wlan0 show
    station wlan0 scan
    station wlan0 get-networks
    station wlan0 connect `YOUR_SSID`
    YOUR_WIFI_PASSWORD
    # ctrl+d to exit iwctl

    # check connection
    ping archlinux.org

    # Start arch installation
    archinstall

```

* **Options that i use:**

* **Archinstall language:** us
* **Keyboard input:** br-abnt2
* **Mirror region:** \[brazil\]
* **Disk:** partition > ext4 no /home partition
* **Bootloader:** grub
* **Swap:** true
* **Hostname:** archlinux
* **Root password:** `YOUR_ROOT_PASSWORD`, `CONFIRM_ROOT_PASSWORD`
* **New user account:** `YOUR_USERNAME`, `YOUR_PASSWORD`, `CONFIRM_YOUR_PASSWORD`, sudo user: true
* **Profile:** minimal
* **Audio:** pipewire
* **Packages:** git curl vim
* **Network:** networkmanager
* **Timezone:** America/Sao_Paulo
* **Time sync:** true
* Click on `install`
* chroot -> no
* `reboot`
