## Dotfiles

* My arch environment config files;
* this README can be outdated so be careful;
* Do not use this unless you know what you're doing;
* Fork this if you want to use it – I'll be pushing updates that might break things.

* [**INSTALL**](./INSTALL.md)

## AFTER SETUP

* use `git pull` in dotfiles to keep it up to date
* use these commands to update the system from time to time

```sh

    # add new packages here
    update-pacman # -Syu for complete update

```

```sh

    # add new packages here
    update-yay # -Suy for complete update

```

```sh

    # WARN: THIS COMMAND REPLACES CONFIG FILES
    RUN_SCRIPT=true config-sync

```

```sh

    # WARN: THIS COMMAND REPLACES SHELL FILES
    RUN_SCRIPT=true shell-sync

```

* Important Links

- [Arch System Maintenance](https://wiki.archlinux.org/title/System_maintenance)
