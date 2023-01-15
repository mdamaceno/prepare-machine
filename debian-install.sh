#!/usr/bin/env sh

set -e

# This script is used to install Debian on a new machine.

CURRENT_USER=$USER

INITIAL_PACKAGES="git htop curl wget vim neovim bash-completion"
DRIVERS_PACKAGES="firmware-amd-graphics firmware-atheros"
GRAPHICS_PACKAGES="xorg"
XFCE_PACKAGES="xfce4 xfce4-goodies xfce4-terminal menulibre"
X_PACKAGES="p7zip-full zip unzip rar unrar zstd"
DEVELOPMENT_PACKAGES="build-essential cmake python3-dev python3-pip autoconf automake libtool cmake libyaml-dev libpq-dev libmariadb-dev sqlite3"
PLATFORM_APP_PACKAGES="snapd flatpak"
MEDIA_PACKAGES="vlc gimp inkscape"
BROWSER_PACKAGES="firefox-esr chromium"

# Enter as root
su -

> /etc/apt/sources.list

echo "deb http://mirror.unesp.br/debian/ bookworm main contrib non-free" >> /etc/apt/sources.list
echo "deb http://mirror.unesp.br/debian/ bookworm main contrib non-free" >> /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security bookworm main contrib non-free" >> /etc/apt/sources.list

# Update the system
apt update && apt upgrade -y

# Install packages
apt install -y $INITIAL_PACKAGES $DRIVERS_PACKAGES $GRAPHICS_PACKAGES $XFCE_PACKAGES $X_PACKAGES $DEVELOPMENT_PACKAGES $PLATFORM_APP_PACKAGES $MEDIA_PACKAGES $BROWSER_PACKAGES

source /etc/bash_completion

# Install docker
snap install docker

source PATH=$PATH:/snap/bin

addgroup --system docker
adduser $CURRENT_USER docker
newgrp docker
snap disable docker
snap enable docker
