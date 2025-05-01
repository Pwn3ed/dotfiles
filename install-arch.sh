#!/bin/bash

## connect to wifi
## iwctl
## station wlan0 show
## station wlan0 connect ssid
## password

## dont need to set pacman keys cuz its done auto

## archinstall

##  INFO: ARCHINSTALL
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

	# INFO: grim - Screenshot tool and slurp for screen selection (installed from official repo)
	if ask "Install screenshot tools?"; then
		sudo pacman -S --noconfirm grim slurp
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
	fi
fi

echo
echo "Installation completed!"
