#!/usr/bin/env bash

APP_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
APP_INSYNC="https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.1.4.40797-bionic_amd64.deb"
KEY_WINE="https://dl.winehq.org/wine-builds/winehq.key"
PPA_WINE="https://dl.winehq.org/wine-builds/ubuntu/"

DOWNLOADS_APP="$HOME/Downloads/App"

APP_INSTALL=(
mint-meta-codecs
git
winff
guvcview
nemo-dropbox
snapd
)

sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

sudo dpkg --add-architecture i386

sudo apt update -y

wget -nc "$KEY_WINE"
sudo apt-key add winehg.key
sudo apt-add-repository "deb $PPA_WINE bionic main"

sudo apt update -y

mkdir "$DOWNLOADS_APP"
wget -c "$APP_GOOGLE_CHROME"

sudo dpkg -i $DOWNLOADS_APP/*.deb

for name_app in ${APP_INSTALL[@]}; do
	if ! dpkg -l | grep $name_app; then
		apt install "$name_app" -y
	else
		echo "[INSTALL] - $name_app"
	fi
done

sudo apt install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 -y

sudo flatpak install flathub com.obsproject.Studio -y

sudo snap install gimp
sudo snap install spotify
sudo snap install slack --classic

sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y

