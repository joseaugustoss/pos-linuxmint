#!/usr/bin/env bash

APP_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
APP_INSYNC="https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.1.4.40797-bionic_amd64.deb"
APP_GITDESKTOP="https://github.com/shiftkey/desktop/releases/download/release-2.4.1-linux2/GitHubDesktop-linux-2.4.1-linux2.deb"
PPA_PHP="ppa:ondrej/php"

DOWNLOADS_APP="$HOME/Downloads/App"

APP_INSTALL=(
snapd
mint-meta-codecs
winff
guvcview
nemo-dropbox
apache2
software-properties-common
mariadb-server
build-essential
python-software-properties
tmux
vlc
git
gcc
g++ 
make
)

sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

sudo dpkg --add-architecture i386

sudo apt update -y

sudo apt-add-repository "$PPA_PHP" -y

sudo apt update -y

mkdir "$DOWNLOADS_APP"
wget -c "$APP_GOOGLE_CHROME" -P "$DOWNLOADS_APP"
wget -c "$APP_GITDESKTOP" -P "$DOWNLOADS_APP"

sudo dpkg -i $DOWNLOADS_APP/*.deb
sudo apt -f install

for name_app in ${APP_INSTALL[@]}; do
	if ! dpkg -l | grep $name_app; then
		sudo apt install  "$name_app" -y
	else
		echo "[INSTALL] - $name_app"
	fi
done

sudo systemctl start apache2
sudo systemctl enable apache2
sudo a2enmod rewrite
sudo a2enmod ssl

sudo systemctl restart apache2

sudo apt install -y libapache2-mod-php7.4 php7.4-common php7.4-mysql php7.4-xml php7.4-xmlrpc php7.4-curl php7.4-gd php7.4-imagick php7.4-cli php7.4-dev php7.4-imap php7.4-mbstring php7.4-opcache php7.4-soap php7.4-zip php7.4-intl php-gettext php-mbstring php-dev php-xdebug php7.4-cli -y

sudo mkdir /etc/apache2/ssl

sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 777 /var/www/html

sudo apt install phpmyadmin -y

sudo apt install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 -y



curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get install -y code snapd

sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg-agent

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"
 
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose

sudo usermod -aG docker $USER

#Instalação do NodeJS 14
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo flatpak install flathub com.obsproject.Studio -y

sudo snap install gimp
sudo snap install spotify
sudo snap install slack --classic
sudo snap install phpstorm --classic
sudo snap install telegram-desktop
sudo snap install postman
sudo snap install beekeeper-studio
sudo snap install obs-studio
sudo snap install android-studio --classic
sudo snap install discord
sudo snap install gitkraken

sudo snap refresh


sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y

