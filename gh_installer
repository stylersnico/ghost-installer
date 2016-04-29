#!/bin/bash

# Colors
CSI="\033["
CEND="${CSI}0m"
CRED="${CSI}1;31m"
CGREEN="${CSI}1;32m"

# Check root access
if [[ "$EUID" -ne 0 ]]; then
	echo -e "${CRED}Sorry, you need to run this as root${CEND}"
  	exit 1
fi

clear
echo "Welcome to the ghost auto-install script.
"
read -n1 -r -p "Your system is going to be updated, press any key to continue..."
echo ""

##
#System Upgrade
##

apt-get update &>/dev/null
apt-get upgrade -y &>/dev/null
aptitude install -y zip vim wget &>/dev/null


##
#Dependencies
##

echo -ne "       Installaling dependencies      [..]\r"
curl -sL https://deb.nodesource.com/setup | sudo bash - &>/dev/null
apt-get install -y nodejs -y &>/dev/null

if [ $? -eq 0 ]; then
	echo -ne "       Installing dependencies        [${CGREEN}OK${CEND}]\r"
	echo -ne "\n"
else
	echo -e "        Installing dependencies      [${CRED}FAIL${CEND}]"
	exit 1
fi

##
#Ghost
##

echo -ne "       Installaling Ghost      [..]\r"
mkdir -p /var/www/ &>/dev/null
cd /var/www/ &>/dev/null
wget https://ghost.org/zip/ghost-latest.zip &>/dev/null
unzip -d ghost ghost-latest.zip &>/dev/null
cd ghost/ &>/dev/null
npm install --production &>/dev/null
cp config.example.js config.js &>/dev/null
rm config.example.js &>/dev/null

if [ $? -eq 0 ]; then
	echo -ne "       Installaling Ghost        [${CGREEN}OK${CEND}]\r"
	echo -ne "\n"
else
	echo -e "        Installaling Ghost      [${CRED}FAIL${CEND}]"
	exit 1
fi

echo -ne "       Creating Ghost user      [..]\r"
adduser --shell /bin/bash --gecos 'Ghost application' ghost
chown -R ghost:ghost /var/www/ghost/
adduser ghost sudo
if [ $? -eq 0 ]; then
	echo -ne "       Creating Ghost user        [${CGREEN}OK${CEND}]\r"
	echo -ne "\n"
else
	echo -e "        Creating Ghost user      [${CRED}FAIL${CEND}]"
	exit 1
fi

##
#Install PM2 - Auto Start Ghost
##

echo -ne "       Installaling PM2 to auto start Ghost      [..]\r"
runuser -l ghost -c 'cd /var/www/ghost/'
runuser -l ghost -c 'sudo npm install -g pm2'
runuser -l ghost -c 'echo "export NODE_ENV=production" >> ~/.profile'
runuser -l ghost -c 'source ~/.profile'
runuser -l ghost -c 'pm2 kill'
runuser -l ghost -c 'pm2 start index.js --name ghost'
runuser -l ghost -c 'pm2 dump'
runuser -l ghost -c 'sudo pm2 startup debian'

if [ $? -eq 0 ]; then
	echo -ne "       Installaling PM2 and startup script        [${CGREEN}OK${CEND}]\r"
	echo -ne "\n"
else
	echo -e "        Installaling PM2 and startup script      [${CRED}FAIL${CEND}]"
	exit 1
fi

echo "Congratulations, your ghost software is no available here : [${CGREEN}http://127.0.0.1:2368${CEND}]\r
Please use a reverse proxy like nginx to access it"
