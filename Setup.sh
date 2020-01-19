#!/bin/bash
#V1.0
# Set a function for Apps

function EssentialApps () {
  sudo apt install curl build-essential exfat-utils git openvpn htop git apt-transport-https wget python-apt snapd openssh-server openssh-client net-tools neofetch network-manager-openvpn-gnome flatpak -y
  sudo snap install vlc
}

function ukuu () {
if [ -e /usr/bin/ukuu ] ;then
echo -e "\e[92mukuu\e[0m is already installed... Skipping"
  else
  echo "Adding ukuu repo"
  sudo add-apt-repository ppa:teejee2008/ppa -y >> ~/Desktop/script.log 2>&1
  echo -e "\e[92mOK\e[0m"
  sleep 4
  sudo apt install ukuu
fi
}

function brave () {
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
  sudo apt install brave-browser
fi
}

function lutris () {
if [ -e /usr/bin/lutris ] ;then
  echo -e "\e[92mlutris\e[0m is already installed... Skipping"
else 
  echo "Adding lutris repo"
  sudo add-apt-repository ppa:lutris-team/lutris -y >> ~/Desktop/script.log 2>&1
  ehco -e "\e[92mOK\e[0m"
  sleep 3
  sudo apt install lutris
fi 
}

function exodus.wallet () {
echo "installing git. Will skip if already installed" 
sudo apt install git > /dev/null 2>&1
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
  echo -e "\e[92mOK\e[0m"
  echo "Run 'exodus-update' without quotes to finish the install"
fi
}

function riot.im () {
  sudo apt install snapd > /dev/null 2>&1
  if  [ -e /snap/bin/riot-web ] ;then 
  echo -e "\e[92mriot\e[0m is already installed... Skipping"
else
  echo "Installing riot-im"
  sudo snap install riot-web -y >> ~/Desktop/script.log 2>&1
  echo -e "\e[92mOK\e[0m"
  sleep 5
fi
}

function sublime.text () {
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
  sudo apt update 
  sudo apt install sublime-text
fi 
}

function plex.player () {
  if [ -e /var/lib/flatpak/app/tv.plex.PlexMediaPlayer ] ;then 
  echo -e "\e[92mPlex\e[0m is already installed... Skipping"
  sleep 5
else 
  echo "Installing Plex Media Player"
  sudo apt install flatpak > /dev/null 2>&1
  sudo flatpak install https://knapsu.eu/data/plex/tv.plex.PlexMediaPlayer.flatpakref -y
  echo -e "\e[92mOK\e[0m"
fi
}

function discord () {
    if [ -e /usr/bin/discord ] ;then 
  echo -e "\e[92mDiscord\e[0m is already installed... Skipping"
  sleep 5
else 
  echo "Installing Discord"
  sudo apt install discord
  echo -e "\e[92mOK\e[0m"
fi
}

function help () {
echo ""
echo -e "                     \e[92;3;4;1mIssues with installing apps\e[0m"
echo ""
echo "If your having issues with installing please run the following:"
echo "sudo apt --fix-broken install"
echo "sudo apt autoremove"
echo "sudo dpkg --configure -a"
echo ""
echo -e "                    \e[92;3;4;1mApps within '#Essential Apps'\e[0m"
echo ""
echo "curl build-essential exfat-utils git openvpn htop apt-transport-https wget python-apt snapd openssh-server openssh-client net-tools neofetch network-manager-openvpn-gnome flatpak vlc"
}

function slack () {
  if [ -e /snap/bin/slack ] ;then
    echo -e "\e[92mSlack\e[0m is already installed... Skipping"
  else
    echo "Installing Slack "
    sudo apt insall snapd > /dev/null 2>&1
    sudo snap install slack
    echo -e "\e[92mOK\e[0m"
  fi
}

# Choice for installing

PS3='Please enter your #Number: '
options=("Help" "All Apps" "Essential Apps" "Brave" "Discord" "Exodus-Wallet" "Lutris" "Plex" "Riot.im" "Slack" "Sublime-text" "Ukuu" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Help")
            help
            ;;
        "All Apps")
            EssentialApps
            brave
            exodus.wallet
            lutris
            plex.player
            riot.im
            slack
            sublime.text
            ukuu
            sleep 3
            sudo apt autoremove
            ;;
        "Essential Apps")
            EssentialApps
            ;;
        "Brave")
            brave
            ;;
        "Discord")
            discord
            ;;
        "Exodus-Wallet")
            exodus.wallet
            ;;
        "Lutris")
            lutris
            ;;
        "Plex")
            plex.player
            ;;
        "Riot.im")
            riot.im
            ;;
        "Slack")
            slack
            ;;
        "Sublime-text")
            sublime.text
            ;;
        "Ukuu")
            ukuu
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
