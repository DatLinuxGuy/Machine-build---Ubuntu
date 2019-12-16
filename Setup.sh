#!/bin/bash

# This script is for new machines. 

# The list of apps installed - 
# Curl, Build-essential, Exfat-utils, Git, Openvpn, Htop, Apt-transport-https, Discord, Wget, Python-apt, Snapd, sublime, brave-browser, DXVK, ukuu, lutris, wine-stable, openssh-server, openssh-client, net-tools, lutris, sublime-text, riot-web, neofetch, vlc, network-manager-openvpn-gnome

time=$(date +%R)

if [ -e ~/Desktop/script.log ] ;then
	cd ~/Desktop
	mv script.log script.log.incomplete
else
	if [ -e ~/Desktop/script.log.incomplete ] ;then 
		mv script.log.incomplete script.log.incomplete2
		cd
	fi
 fi

# Updating default packages
echo "Updating & upgrading current apps etc, this may take a while."
sudo apt -qq update > ~/Desktop/script.log 2>&1
sudo apt -qq upgrade -y >> ~/Desktop/script.log 2>&1
echo -e "\e[92mUpdate & Upgrade complete\e[0m"
sleep 7
echo "Installing Curl Build-essential Exfat-utils Git Openvpn Htop Apt-transport-https Wget Python-apt Snapd"
sudo apt install curl build-essential exfat-utils git openvpn htop apt-transport-https wget python-apt snapd -y >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 3

# Adding sublime
if [ -e /snap/bin/subl ] ;then 
	echo -e "\e[92msublime\e[0m is already installed... Skipping"
else
	echo "Downloading and adding pub key for Sublime"
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - >> ~/Desktop/script.log 2>&1
	echo -e "\e[92mOK\e[0m"
	sleep 5
	echo "Adding Sublime to repo"
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list >> ~/Desktop/script.log 2>&1
	echo -e "\e[92mOK\e[0m"
	sleep 5
fi 

# Adding Brave stable
if [ -e /usr/bin/brave-browser ] ;then 
	echo -e "\e[92mBrave\e[0m is already installed... Skipping"
else
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
fi


# Download Exodus wallet
if [ -e /usr/local/bin/exodus-update ] ;then
	echo -e "\e[92mexodus-update\e[0m is already installed... Skipping"
else
	echo "Downloading Exodus-Wallet-Updater script to ~/Downloads"
	git clone https://github.com/DatLinuxGuy/Exodus-Wallet-Updater >> ~/Desktop/script.log 2>&1
	echo -e "\e[92mOK\e[0m"
	sleep 5
	echo "Installing Exodus-Wallet from ~/Downloads"
	sudo chmod +x Exodus-Wallet-Updater/exodus-update >> ~/Desktop/script.log 2>&1
	sleep 5
	sudo mv Exodus-Wallet-Updater/exodus-update /usr/local/bin >> ~/Desktop/script.log 2>&1
	sleep 5
	exodus-update 
	echo -e "\e[92mOK\e[0m"
fi

# Adding repos - ukuu  
if [ -e /usr/bin/ukuu ] ;then
	echo -e "\e[92mukuu\e[0m is already installed... Skipping"
else
	echo "Adding ukuu repo"
	sudo add-apt-repository ppa:teejee2008/ppa -y >> ~/Desktop/script.log 2>&1
	echo -e "\e[92mOK\e[0m"
fi

# Adding lutris
if [ -e /usr/bin/lutris ] ;then
	echo -e "\e[92mlutris\e[0m is already installed... Skipping"
else 
	echo "Adding lutris repo"
	sudo add-apt-repository ppa:lutris-team/lutris -y >> ~/Desktop/script.log 2>&1
	ehco -e "\e[92mOK\e[0m"
fi 

# Adding Riot.im 
if  [ -e /snap/bin/riot-web ] ;then 
	echo -e "\e[92mriot\e[0m is already installed... Skipping"
else
	echo "Installing riot-im"
	sudo snap install riot-web -y >> ~/Desktop/script.log 2>&1
	echo -e "\e[92mOK\e[0m"
	sleep 5
fi

# Adding discord 
if  [ -e /snap/bin/discord ] ;then 
	echo -e "\e[92mdisord\e[0m is already installed... Skipping"
else
	echo "Installing discord"
	sudo snap install discord -y >> ~/Desktop/script.log 2>&1
	echo -e "\e[92mOK\e[0m"
	sleep 5
fi

# Download & Install Steam
cd ~/Downloads 
if [ -e /usr/bin/steam ] ;then
	echo -e "\e[92mSteam\e[0m is already installed... Skipping"
else
	echo "Downloading Steam to ~/Downloads"
	wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb >> ~/Desktop/script.log 2>&1
	echo -e "\e[92mOK\e[0m"
	sleep 5
	if [ -e ~/Downloads/steam.deb ] ;then
		echo "Installing Steam from ~/Downloads"
		sudo dpkg -i steam.deb >> ~/Desktop/script.log 2>&1
		echo -e "\e[92mOK\e[0m"
		sleep 5
	else 
		echo " Cant find steam.deb attempting to download again....."
		cd ~/Downloads
		sleep 3
		wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb >> ~/Desktop/script.log 2>&1
		sleep 5
		if [ -e ~/Downloads/steam.deb ] ;then 
			echo "Installing Steam from ~/Downloads"
			sudo dpkg -i steam.deb >> ~/Desktop/script.log 2>&1
			echo -e "\e[92mOK\e[0m"
			sleep 5
		else
			echo "Something is wrong, Please check script.log"
		fi
	fi
fi

# Adding wine
if [ -e /usr/bin/wine ] ;then
	echo -e "\e[92mWine\e[0m is already installed... Skipping"
else
	echo "Adding 32bit arch for wine"
	sudo dpkg --add-architecture i386 >> ~/Desktop/script.log 2>&1
	echo -e "\e[92mOK\e[0m"
	echo "Downloading key for wine"
	wget -nc https://dl.winehq.org/wine-builds/winehq.key >> ~/Desktop/script.log 2>&1
	echo -e "\e[92mOK\e[0m"
	sleep 5
	echo "Adding wine key"
	sudo apt-key add winehq.key >> ~/Desktop/script.log 2>&1
	echo -e "\e[92mOK\e[0m"
	sleep 5
	echo "Adding wine repo"
	sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' -y >> ~/Desktop/script.log 2>&1
	echo -e "\e[92mOK\e[0m"
	sleep 5
# Installing wine stable
	echo "Installing wine-stable, This may take a while"
	sudo apt install --install-recommends winehq-stable -y >> ~/Desktop/script.log 2>&1
	echo -e "\e[92mOK\e[0m"
fi

# Acivating wine 
echo -e "\e[92mPlease install all prompts from wine and then hit 'OK' when all packages are completee\e[0m"
winecfg >> ~/Desktop/script.log 2>&1
echo -e "\e[92mOK\e[0m"
sleep 5

# Installing DXVK
echo "Installing DXVK"
if [ ~/Downloads/dxvk-1.4.6.tar.gz ] ;then

	cd ~/Downloads
	wget https://github.com/doitsujin/dxvk/releases/download/v1.4.6/dxvk-1.4.6.tar.gz >> ~/Desktop/script.log 2>&1
	sleep 4
	tar -xvf dxvk-1.4.6.tar.gz 
	sleep 3
	cd dxvk-1.4.6/
	sleep 4
	chmod +x setup_dxvk.sh
	./setup_dxvk.sh install
	sleep 5
	cd ../
	echo -e "\e[92mOK\e[0m"
else 
	echo "Having issues installing/downloading. Attempting again"
	sleep 3
	cd ~/Downloads
	echo "Downloading DXVK to ~/Downloads"
	wget https://github.com/doitsujin/dxvk/releases/download/v1.4.6/dxvk-1.4.6.tar.gz >> ~/Desktop/script.log 2>&1
	sleep 4
		if [ ~/Downloads/dxvk-1.4.6.tar.gz ] ;then
			echo -e "\e[92mOK\e[0m"
			tar -xvf dxvk-1.4.6.tar.gz 
			sleep 3
			cd dxvk-1.4.6/
			chmod +x setup_dxvk.sh
			./setup_dxvk.sh install
			sleep 5
			cd ../
			echo -e "\e[92mOK\e[0m"
	fi
fi


# Installing apps
echo "Installing openssh-server openssh-client net-tools lutris sublime-text brave-browser neofetch vlc network-manager-openvpn-gnome flatpak, This may take a while"
sudo apt install openssh-server openssh-client net-tools lutris sublime-text brave-browser neofetch vlc network-manager-openvpn-gnome flatpak -y >> ~/Desktop/script.log 2>&1 
echo -e "\e[92mOK\e[0m"
sleep 10

# Install Plex Media Player
if [ -e /var/lib/flatpak/app/tv.plex.PlexMediaPlayer ] ;then 
	echo -e "\e[92mPlex\e[0m is already installed... Skipping"
	sleep 5
else 
	echo
	sudo flatpak install https://knapsu.eu/data/plex/tv.plex.PlexMediaPlayer.flatpakref -y
	echo -e "\e[92mOK\e[0m"
fi


# Running removal of files
echo "Auto removing unneeded packages"
sudo apt autoremove -y >> ~/Desktop/script.log 2>&1 
echo -e "\e[92mOK\e[0m"
echo "Removing files downloaded in ~/Downloads"
rm -rf dxvk-1.4.6* steam.deb Exodus-Wallet-Updater >> ~/Desktop/script.log 2>&1 
echo -e "\e[92mOK\e[0m"
sleep 1
mv ~/Desktop/script.log ~/Desktop/script.log$time
sleep 1
echo "Script has finished :)"
