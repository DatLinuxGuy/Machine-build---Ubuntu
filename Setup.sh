#!/bin/bash

# This script is for new machines setup. 

#The list of apps installed - 
#htop, ukuu, openssh, wine(latest staging), sublime-text, brave, exodus wallet, GPU drivers (nvidia or AMD), net-tools, exfat-utils, git, lutris, build-essentials, openvpn, snapd, DXVK


#set sudoers file to 180 mins
sudo sed -e '/env_reset/env_reset,timestamp_timeout=180' /etc/sudoers

# Updating default packages
sudo apt update && sudo apt ugrade -y
sudo apt install curl build-essential exfat-utils git openvpn htop apt-transport-https wget python-apt snapd -y
# Adding 32bit for wine
sudo dpkg --add-architecture i386 

 # Downloading and Adding files
# Adding sublime
wget -qO - https://download.sublimetext.com /sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
# Adding wine
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
# Adding Brave stable
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
source /etc/os-release
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-${UBUNTU_CODENAME}.list
# Download Steam & exodus-updater, DXVK v1.4.6 (maybe old), 
wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb ~/Downloads
wget https://github.com/DatLinuxGuy/Exodus-Wallet-Updater/blob/master/exodus-update ~/Downloads
wget https://github.com/doitsujin/dxvk/releases/download/v1.4.6/dxvk-1.4.6.tar.gz ~/Downloads
# Adding repos - ukuu, lutris, wine-staging  
sudo add-apt-repository ppa:teejee2008/ppa 
sudo add-apt-repository ppa:lutris-team/lutris
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
# Adding Riot.im
sudo wget -O /usr/share/keyrings/riot-im-archive-keyring.gpg https://packages.riot.im/debian/riot-im-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/riot-im-archive-keyring.gpg] https://packages.riot.im/debian/ $(lsb_release -cs) main" |
    sudo tee /etc/apt/sources.list.d/riot-im.list

# Installing apps
sudo apt install openssh-server openssh-client net-tools lutris sublime-text brave-browser riot-web -y
# Installing Steam
sudo dpkg -i ~/Downloads/steam.deb
rm -r ~/Downloads/steam.deb
# Installing Exodus-Wallet
sudo chmod +x ~/Downloads/exodus-update
sudo mv ~/Downloads/exodus-update /usr/local/bin
exodus
# Installing wine staging
sudo apt install --install-recommends winehq-staging -y
# Installing DXVK
tar -xvf ~/Downloads/dxvk-1.4.6.tar.gz
~/Downloads/dxvk-1.4.6/setup_dxvk.sh install

# install needed files for wine
winecfg




