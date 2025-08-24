#!/bin/bash
set -euo pipefail

SSH_PORT=2222
SEQ_LENGTH=5
SEQ_TIMEOUT=7
UFW_COMMAND_OPEN="/usr/sbin/ufw allow $SSH_PORT/tcp"
UFW_COMMAND_CLOSE="/usr/sbin/ufw delete allow $SSH_PORT/tcp"

echo "Updating system and installing required packages..."
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm openssh knockd iptables-nft

echo "Hardening SSH configuration..."
SSH_CONFIG="/etc/ssh/sshd_config"

# Backup existing sshd_config before modifying
sudo cp "$SSH_CONFIG" "${SSH_CONFIG}.bak.$(date +%F-%T)"

# Use a robust method to replace or add config lines
sudo sed -i -E "
  s/^#?Port .*/Port $SSH_PORT/;
  s/^#?PermitRootLogin .*/PermitRootLogin no/;
  s/^#?PasswordAuthentication .*/PasswordAuthentication no/;
  s/^#?ChallengeResponseAuthentication .*/ChallengeResponseAuthentication no/;
  s/^#?PermitEmptyPasswords .*/PermitEmptyPasswords no/;
  s/^#?LogLevel .*/LogLevel VERBOSE/;
" "$SSH_CONFIG"

echo "Restarting SSH daemon..."
sudo systemctl restart sshd
sudo systemctl enable sshd

echo "Generating random knock sequence..."
declare -a KNOCK_PORTS=()
while [ "${#KNOCK_PORTS[@]}" -lt "$SEQ_LENGTH" ]; do
    PORT=$(( RANDOM % 16383 + 49152 ))
    if [[ ! " ${KNOCK_PORTS[*]} " =~ " $PORT " ]]; then
        KNOCK_PORTS+=("$PORT")
    fi
done
echo "Knock sequence: ${KNOCK_PORTS[*]}"

echo "Updating /etc/knockd.conf..."
sudo tee /etc/knockd.conf > /dev/null <<EOF
[options]
    logfile = /var/log/knockd.log

[openSSH]
    sequence    = $(IFS=,; echo "${KNOCK_PORTS[*]}")
    seq_timeout = $SEQ_TIMEOUT
    command     = $UFW_COMMAND_OPEN
    tcpflags    = syn

[closeSSH]
    sequence    = $(IFS=,; echo "${KNOCK_PORTS[*]}" | tac -s,)
    seq_timeout = $SEQ_TIMEOUT
    command     = $UFW_COMMAND_CLOSE
    tcpflags    = syn
EOF

echo "Adding stealth iptables rules for knock ports..."
for p in "${KNOCK_PORTS[@]}"; do
    sudo iptables -A INPUT -p tcp --dport "$p" -j NFLOG --nflog-group 0
done

echo "Saving iptables rules for persistence..."
sudo iptables-save | sudo tee /etc/iptables/iptables.rules > /dev/null
sudo systemctl enable iptables

echo "Enabling and starting knockd service..."
sudo systemctl enable knockd
sudo systemctl restart knockd

echo "=============================================="
echo "SSH is configured to run on port $SSH_PORT"
echo "Use this knock sequence to open SSH:"
echo "${KNOCK_PORTS[*]}"
echo "Use the reverse sequence to close SSH:"
echo "$(echo "${KNOCK_PORTS[*]}" | tac -s ' ')"
echo "SAVE THIS SEQUENCE SECURELY — IT WILL NOT BE SHOWN AGAIN."
echo "=============================================="
