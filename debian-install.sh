#!/usr/bin/env bash

# This script is used to install Debian on a new machine.

CURRENT_USER="$1"

if [ ! -n "$CURRENT_USER" ]; then
  echo "Error: No user specified."
  exit 1
fi

if [ $EUID -ne 0 ]; then
  echo "Please run this script as root"
  exit 1
fi

INITIAL_PACKAGES="git htop curl wget vim bash-completion"
DRIVERS_PACKAGES="firmware-amd-graphics firmware-atheros"
KDE_PACKAGES="kde-plasma-desktop gwenview kate kcalc kde-spectacle okular plasma-pa kmix plasma-runners-addons plasma-widgets-addons plasma-nm filelight sweeper"
X_PACKAGES="p7zip-full zip unzip rar unrar zstd"
DEVELOPMENT_PACKAGES="build-essential cmake python3-dev python3-pip autoconf automake libtool cmake libyaml-dev libpq-dev libmariadb-dev sqlite3"
PLATFORM_APP_PACKAGES="snapd flatpak"
MEDIA_PACKAGES="vlc gimp inkscape imagemagick"
BROWSER_PACKAGES="chromium"
OFFICE_PACKAGES="libreoffice"
NETWORK_PACKAGES="nmap openvpn network-manager network-manager-openvpn"
OTHER_PACKAGES="transmission-qt zsh ccrypt silversearcher-ag fzf tmux stow xclip youtube-dl exa alacritty neofetch ttf-mscorefonts-installer"

# Update repositories
echo "" > /etc/apt/sources.list
echo "deb http://mirror.unesp.br/debian/ bookworm main contrib non-free" >> /etc/apt/sources.list
echo "deb http://mirror.unesp.br/debian/ bookworm-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security bookworm-security main contrib non-free" >> /etc/apt/sources.list

# Update the system
apt update && apt upgrade -y

# Install packages
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
apt install -y $INITIAL_PACKAGES \
  $DRIVERS_PACKAGES \
  $KDE_PACKAGES \
  $X_PACKAGES \
  $DEVELOPMENT_PACKAGES \
  $PLATFORM_APP_PACKAGES \
  $MEDIA_PACKAGES \
  $BROWSER_PACKAGES \
  $OFFICE_PACKAGES \
  $NETWORK_PACKAGES \
  $OTHER_PACKAGES

# Install Nerd Fonts
FONT_DIR="/home/$CURRENT_USER/.fonts"
mkdir $FONT_DIR
mkdir $FONT_DIR/DroidSansMono && wget -O $FONT_DIR/DroidSansMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/DroidSansMono.zip
mkdir $FONT_DIR/DejaVuSansMono && wget -O $FONT_DIR/DejaVuSansMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/DejaVuSansMono.zip
mkdir $FONT_DIR/FiraCode && wget -O $FONT_DIR/FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip
mkdir $FONT_DIR/FiraMono && wget -O $FONT_DIR/FiraMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraMono.zip
mkdir $FONT_DIR/Inconsolata && wget -O $FONT_DIR/Inconsolata.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Inconsolata.zip
mkdir $FONT_DIR/JetBrainsMono && wget -O $FONT_DIR/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip
mkdir $FONT_DIR/Noto && wget -O $FONT_DIR/Noto.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Noto.zip

unzip $FONT_DIR/DroidSansMono.zip -d $FONT_DIR/DroidSansMono && rm -f $FONT_DIR/DroidSansMono.zip
unzip $FONT_DIR/DejaVuSansMono.zip -d $FONT_DIR/DejaVuSansMono && rm -f $FONT_DIR/DejaVuSansMono.zip
unzip $FONT_DIR/FiraCode.zip -d $FONT_DIR/FiraCode && rm -f $FONT_DIR/FiraCode.zip
unzip $FONT_DIR/FiraMono.zip -d $FONT_DIR/FiraMono && rm -f $FONT_DIR/FiraMono.zip
unzip $FONT_DIR/Inconsolata.zip -d $FONT_DIR/Inconsolata && rm -f $FONT_DIR/Inconsolata.zip
unzip $FONT_DIR/JetBrainsMono.zip -d $FONT_DIR/JetBrainsMono && rm -f $FONT_DIR/JetBrainsMono.zip
unzip $FONT_DIR/Noto.zip -d $FONT_DIR/Noto && rm -f $FONT_DIR/Noto.zip

chown -R $CURRENT_USER:$CURRENT_USER $FONT_DIR

# Link Snap packages to XFCE
ln -s /var/lib/snapd/desktop/applications /usr/share/applications/snapd
echo "export PATH=\$PATH:/snap/bin" >> /home/$CURRENT_USER/.bashrc

# Install docker
snap install docker
addgroup --system docker
adduser $CURRENT_USER docker

# Install Slack
snap install slack --classic

# Install Postman
snap install postman

# Install Visual Studio Code
snap install code --classic

# Install Dbeaver
snap install dbeaver-ce

# Install Firefox
snap install firefox

# Install Neovim
snap install --beta nvim --classic
