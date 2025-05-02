#!/bin/bash

## WARN: DOWNLOAD SIZE:
## MINIMAL: ~6-8 GB
## FULL: ~12-20 GB

##  INFO: ARCH INSTALL
### # connect to wifi
### iwctl
### station wlan0 show
### station wlan0 connect ssid
### password
### ctrl+d # exit iwctl
### run archinstall
### archinstall language: us
### keyboard input: br or abnt-2
### mirror region: [brazil]
### disk: partition > ext4 no /home partition
### disk encryption: false
### bootloader: grub
### swap: true
### hostname: archlinux
### root password: ************
### new user account: username, password, confirm password, sudo user true
### profile: minimal
### audio: pipewire
### packages: git curl
### network: use current config? or NetworkManager ?
### timezone: America/Sao_Paulo
### time sync: true
### INSTALL
### reboot
### login
### nmcli device wifi connect ssid password ********

# ===== GLOBAL FLAG =====
ACCEPT_ALL=false

# ===== ASK FUNCTION =====
ask() {
	if [ "$ACCEPT_ALL" = true ]; then
		return 0
	fi
	read -p "$1 (Y/n): " -n 1 -r
	echo
	[[ $REPLY =~ ^[Yy]$ ]]
}

# ===== ACCEPT ALL PROMPT =====
read -p "Accept all prompts automatically? (Y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	ACCEPT_ALL=true
fi

# ===== SETUP DESKTOP =====
setup-desktop() {
	echo
	echo "## SETUP DESKTOP ENVIRONMENT ##"
	echo

	# INFO: Hyprland - Wayland compositor (installed from official repo)
	if ask "Install Hyprland?"; then
		sudo yay -S --noconfirm hyprland

		# INFO: Hyprpaper - Wallpaper tool for Hyprland (installed from AUR via yay)
		if ask "Install hyprpaper?"; then
			yay -S --noconfirm hyprpaper
		fi

		# INFO: Waybar - Status bar for Wayland (installed from official repo)
		if ask "Install waybar?"; then
			yay -S --noconfirm waybar
		fi
	fi

	# INFO: Dolphin - KDE file manager and Ark - archive tool (installed from official repo)
	if ask "Install Dolphin and Ark?"; then
		yay -S --noconfirm dolphin
		sudo pacman -S --noconfirm ark
	fi

	# INFO: LY - Terminal-based display manager (installed from official repo)
	if ask "Install LY Display Manager?"; then
		sudo pacman -S --noconfirm ly
	fi
}

# ===== TERMINAL EMULATOR =====
terminal-emulator() {
	echo "Choose a terminal emulator: (alacritty / wezterm / none)"
	read TERM_EMU
	case $TERM_EMU in
		alacritty)
			echo "Installing Alacritty - Fast GPU terminal (installed from official repo)"
			sudo pacman -S --noconfirm alacritty
			;;
		wezterm)
			echo "Installing WezTerm - GPU-accelerated terminal (installed from official repo)"
			sudo pacman -S --noconfirm wezterm
			;;
		*)
			echo "Skipping terminal emulator"
			;;
	esac
}

# ===== SHELL =====
shell() {
	# INFO: Install zsh (Z shell) and oh-my-zsh (for customization)
	if ask "Install Zsh and Oh-My-Zsh?"; then
		sudo pacman -S --noconfirm zsh
		chsh -s $(which zsh)

		# Install oh-my-zsh for better shell customization
		if ask "Install Oh-My-Zsh?"; then
			sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
		fi
	fi
}

# ===== START MENU =====
start-menu() {
	echo "Choose an application launcher: (wofi / rofiwayland / none)"
	read START_MENU
	case $START_MENU in
		wofi)
			echo "Installing Wofi - Wayland app launcher (installed from official repo)"
			sudo pacman -S --noconfirm wofi
			;;
		rofiwayland)
			echo "Installing Rofi-Wayland - Lightweight launcher (installed from official repo)"
			sudo pacman -S --noconfirm rofi-wayland
			;;
		*)
			echo "Skipping launcher installation"
			;;
	esac
}

# ===== NETWORK PACKAGES =====
network-packages() {
	echo
	echo "## NETWORK PACKAGES ##"
	echo

	# INFO: ldns - DNS library, ufw - Firewall (installed from official repo)
	if ask "Install ldns and ufw?"; then
		sudo pacman -S --noconfirm ldns ufw
	fi

	# INFO: Install NetworkManager for network management (installed from official repo)
	if ask "Install NetworkManager?"; then
		sudo pacman -S --noconfirm NetworkManager
	fi
}

# ===== MISC PACKAGES =====
misc-packages() {
	if ask "Install firefox?"; then
		sudo pacman -S --noconfirm firefox
	fi

	# INFO: GIMP - Image editor (installed from official repo)
	if ask "Install GIMP (image editor)?"; then
		sudo pacman -S --noconfirm gimp
	fi

	# INFO: TLP - Power management for laptops (installed from official repo)
	if ask "Install TLP and TLP-RDW (power management)?"; then
		sudo pacman -S --noconfirm tlp tlp-rdw
	fi

	# INFO: pavucontrol - Audio volume control GUI (installed from official repo)
	if ask "Install pavucontrol (volume control)?"; then
		sudo pacman -S --noconfirm pavucontrol
	fi

	# INFO: tmux - Terminal multiplexer (installed from official repo)
	if ask "Install tmux?"; then
		sudo pacman -S --noconfirm tmux
	fi

	# INFO: neofetch - System information tool (installed from official repo)
	if ask "Install neofetch?"; then
		sudo pacman -S --noconfirm neofetch
	fi

	if ask "Install PDF reader (zathura)?"; then
		sudo pacman -S --noconfirm zathura
	fi

	# INFO: grim - Screenshot tool and slurp for screen selection (installed from official repo)
	if ask "Install screenshot tools?"; then
		sudo pacman -S --noconfirm grim slurp
	fi

	if ask "Install recording tools (Obs)?"; then
		sudo pacman -S --noconfirm obs-studio
	fi

	if ask "Install markdown anotation tool (Obsidian)?"; then
		sudo pacman -S --noconfirm obsidian
	fi
}

# ===== FONTS =====
fonts() {
	# INFO: Install fonts
	if ask "Install ttf-font-awesome and ttf-fira-code-font?"; then
		sudo pacman -S --noconfirm ttf-font-awesome
		yay -S --noconfirm nerd-fonts-fira-code
	fi
}

# ===== DEVELOPER PACKAGES =====
database() {
	if ask "Install mariaDB (mySQL)?"; then
		sudo pacman -S --noconfirm mariadb
		sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
		sudo systemctl enable mariadb
		sudo systemctl start mariadb
		sudo mysql_secure_installation
	fi

	if ask "Install PostgreSQL?"; then
		sudo pacman -S --noconfirm postgresql
		sudo -iu postgres initdb --locale $LANG -D /var/lib/postgres/data
		sudo systemctl enable postgresql
		sudo systemctl start postgresql
		# sudo -iu postgres
	fi

	if ask "Install MongoDB?"; then
		yay -S --noconfirm mongodb-bin
		sudo chown -R mongodb:mongodb /var/lib/mongodb
		sudo chown mongodb:mongodb /tmp/mongodb-27017.sock
		sudo systemctl enable mongodb
		sudo systemctl start mongodb
	fi
}

game() {
	if ask "Install Unity Hub?"; then
		yay -S --noconfirm unityhub
	fi

	if ask "Install LÖVE (Love2D)?"; then
		sudo pacman -S --noconfirm love
	fi
}

latex() {
	if ask "Install latexmk?"; then
		sudo pacman -S --noconfirm latexmk
	fi

	if ask "Install full TeX Live distribution?"; then
		sudo pacman -S --noconfirm texlive-most
	fi
}

developer-packages() {
	if ask "Install C development tools?"; then
		sudo pacman -S --noconfirm gcc gdb make cmake
	fi

	if ask "Install Java (JDK and Maven)?"; then
		sudo pacman -S --noconfirm jdk-openjdk maven
	fi

	if ask "Install Node.js and npm?"; then
		sudo pacman -S --noconfirm nodejs npm
	fi

	if ask "Install Go (Golang)?"; then
		sudo pacman -S --noconfirm go
	fi

	if ask "Install Python and related tools?"; then
		sudo pacman -S --noconfirm python python-pip python-virtualenv pipx
		python -m ensurepip --upgrade
		pipx ensurepath

		# Add pipx path for Zsh if not already added
		if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc; then
			echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
		fi
	fi

	if ask "Install Laravel (PHP framework)?"; then
		/bin/bash -c "$(curl -fsSL https://php.new/install/linux/8.4)"
	fi

	if ask "Install .NET SDK?"; then
		sudo pacman -S --noconfirm dotnet-sdk
	fi

	if ask "Install LuaRocks (Lua package manager)?"; then
		sudo pacman -S --noconfirm luarocks lua
	fi

	if ask "Install tree-sitter CLI?"; then
		sudo pacman -S --noconfirm tree-sitter
	fi

	if ask "Install Docker and Docker Compose?"; then
		sudo pacman -S --noconfirm docker docker-compose
		sudo systemctl enable docker
		sudo systemctl start docker
		sudo usermod -aG docker $USER
	fi

	if ask "Install Android Studio?"; then
		yay -S --noconfirm android-studio
	fi

	if ask "Install Flutter SDK?"; then
		yay -S --noconfirm flutter
	fi

	if ask "Install Rust (via rustup)?"; then
		sudo pacman -S --noconfirm rustup
		rustup default stable
	fi

	if ask "Install Virt-Manager (VM GUI)?"; then
		sudo pacman -S --noconfirm virt-manager qemu libvirt ebtables dnsmasq bridge-utils
		sudo systemctl enable libvirtd
		sudo systemctl start libvirtd
		sudo usermod -aG libvirt,kvm $USER

		echo "uncomment unix_sock_group in /etc/libvirt/libvirtd.conf"
		echo
	fi

	database
	game
	latex
}

# ===== MAIN SCRIPT START =====
echo
echo "## SYSTEM SETUP ##"
echo

# INFO: Update system
if ask "Update system packages?"; then
	sudo pacman -Syu --noconfirm
fi

# INFO: Install basic tools
if ask "Install basic packages (git, curl, etc)?"; then
	sudo pacman -S --noconfirm git gh curl tldr fzf wl-clipboard unzip base-devel ripgrep

	terminal-emulator
	start-menu

	if ask "Install miscellaneous packages?"; then
		misc-packages
	fi

	# INFO: Install yay - AUR helper (if not installed)
	if ask "Install yay (AUR helper)?"; then
		# Check if yay is already installed
		ISYAY=/sbin/yay
		if [ -f "$ISYAY" ]; then 
			echo "yay is already installed."
			yay -Suy --noconfirm
		else
			git clone https://aur.archlinux.org/yay-bin.git
			cd yay-bin || exit
			makepkg -si --noconfirm
			yay -Suy --noconfirm
			cd ..
			rm -rf yay-bin
		fi

		setup-desktop
		fonts

		# INFO: Neovim Nightly
		if ask "Install Neovim Nightly (AUR)?"; then
			yay -S --noconfirm neovim-nightly-bin
		fi

		shell

		if ask "Install developer tools?"; then
			developer-packages
		fi
	fi
fi

echo
echo "Installation completed!"

##  TODO:
### ADD raylib, zig, javafx
