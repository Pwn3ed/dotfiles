#!/bin/bash

wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz

sudo tar xvzf ./ngrok-v3-stable-linux-amd64.tgz -C /usr/local/bin

echo "authentication: ngrok config add-authtoken <token>"
echo "get your token in ngrok web dashboard"

echo "docs: https://ngrok.com/docs/guides/device-gateway/linux/"
