#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm dotnet-sdk libuv mono-msbuild
