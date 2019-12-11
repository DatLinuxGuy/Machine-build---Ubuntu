#!/bin/bash

# This script is for new machines. 

#The list of apps installed - 
# Curl, Build-essential, Exfat-utils, Git, Openvpn, Htop, Apt-transport-https, Wget, Python-apt, Snapd, sublime, brave-browser, DXVK, ukuu, lutris, wine-stable, openssh-server, openssh-client, net-tools, lutris, sublime-text, riot-web, neofetch, vlc


# Updating default packages
echo "Updating & upgrading current apps etc, this may take a while."
sudo apt -qq update > ~/Desktop/script.log 2>&1
sudo apt -qq upgrade -y >> ~/Desktop/script.log 2>&1
echo -e "\e[92mUpdate & Upgrade complete\e[0m"
sleep 7
echo "Installing Curl Build-essential Exfat-utils Git Openvpn Htop Apt-transport-https Wget Python-apt Snapd "
sudo apt install curl build-essential exfat-utils git openvpn htop apt-transport-https wget python-apt snapd -y >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 3

# Adding 32bit for wine
echo "Adding 32bit arch for wine"
sudo dpkg --add-architecture i386 >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5

 # Downloading and Adding files
# Adding sublime
echo "Downloading and adding pub key for Sublime"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5
echo "Adding Sublime to repo"
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5

# Adding wine
echo "Downloading key for wine"
wget -nc https://dl.winehq.org/wine-builds/winehq.key >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5
echo "Adding wine key"
sudo apt-key add winehq.key >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5

# Adding Brave stable
echo "Downloading key for brave-browser"
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5
source /etc/os-release >> ~/Desktop/script.log 2>&1
sleep 5
echo "Adding brave-browser to repo"
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-${UBUNTU_CODENAME}.list >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5

# Download Steam & exodus-wallet-updater, DXVK v1.4.6 (maybe old),
cd ~/Downloads 
echo "Downloading Steam to ~/Downloads"
wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5
echo "Downloading Exodus-Wallet-Updater script to ~/Downloads"
git clone https://github.com/DatLinuxGuy/Exodus-Wallet-Updater >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5
echo "Downloading DXVK to ~/Downloads"
wget https://github.com/doitsujin/dxvk/releases/download/v1.4.6/dxvk-1.4.6.tar.gz >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5

# Adding repos - ukuu, lutris, wine-stable  
echo "Adding/ ukuu - lutris - wine /to the repo"
sudo add-apt-repository ppa:teejee2008/ppa -y >> ~/Desktop/script.log 2>&1
sudo add-apt-repository ppa:lutris-team/lutris -y >> ~/Desktop/script.log 2>&1
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' -y >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5

# Adding Riot.im 
echo "Downloading key for riot-im"
sudo wget -O /usr/share/keyrings/riot-im-archive-keyring.gpg https://packages.riot.im/debian/riot-im-archive-keyring.gpg >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5
echo "Adding riot-im to repo"
echo "deb [signed-by=/usr/share/keyrings/riot-im-archive-keyring.gpg] https://packages.riot.im/debian/ $(lsb_release -cs) main" |
    sudo tee /etc/apt/sources.list.d/riot-im.list >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5

# Installing Steam
echo "Installing Steam from ~/Downloads"
sudo dpkg -i steam.deb >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5

# Installing Exodus-Wallet
echo "Installing Exodus-Wallet from ~/Downloads"
sudo chmod +x Exodus-Wallet-Updater/exodus-update >> ~/Desktop/script.log 2>&1
sleep 5
sudo mv Exodus-Wallet-Updater/exodus-update /usr/local/bin >> ~/Desktop/script.log 2>&1
sleep 5
exodus-update 
echo -e "\e[92mOK\e[0m"

# Installing wine staging
echo "Installing wine-stable, This may take a while"
sudo apt install --install-recommends winehq-stable -y >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"

# Acivating wine 
echo -e "\e[92mPlease install all prompts from wine and then hit 'OK' when all packages are completee\e[0m"
winecfg >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"

# Installing DXVK
echo "Installing DXVK"
tar -xvf dxvk-1.4.6.tar.gz 
sleep 3
cd dxvk-1.4.6/
sleep 4
chmod +x setup_dxvk.sh
./setup_dxvk.sh install
sleep 5
cd ../
echo -e "\e[92mOK\e[0m"

# Installing apps
echo "Installing openssh-server openssh-client net-tools lutris sublime-text brave-browser riot-web neofetch vlc, This may take a while"
sudo apt install openssh-server openssh-client net-tools lutris sublime-text brave-browser riot-web neofetch vlc -y >> ~/Desktop/script.log 2>&1 
echo -e "\e[92mOK\e[0m"
sleep 10

# Running removal of files
echo "Auto removing unneeded packages"
sudo apt autoremove -y >> ~/Desktop/script.log 2>&1 
echo -e "\e[92mOK\e[0m"
echo "Removing files downloaded in ~/Downloads"
rm -rf dxvk-1.4.6* steam.deb Exodus-Wallet-Updater >> ~/Desktop/script.log 2>&1 
echo -e "\e[92mOK\e[0m"
