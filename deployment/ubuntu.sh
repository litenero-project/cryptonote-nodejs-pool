#!/usr/bin/env bash
CURUSER=$(whoami)
sudo timedatectl set-timezone Etc/UTC
sudo apt-get update
cd ~
git clone https://github.com/electroneropool/cryptonote-nodejs-pool.git  # Change this depending on how the deployment goes.
cd cryptonote-nodejs-pool
sh deployment/get_boost.sh
sudo apt-get install ntp
sudo systemctl enable ntp
cd /usr/local/src
sudo git clone --recursive https://github.com/electronero/electronero.git
cd electronero
sh ubuntu_install.sh
echo "Dependencies installation complete"
echo "Download Submodules"
sudo git submodule init
sudo git submodule update
sudo make -j$(nproc)
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
source ~/.nvm/nvm.sh
nvm install v8.9.3
nvm alias default v8.9.3
cd ~/nodejs-pool
npm install
npm install -g pm2
cd cryptonote-nodejs-pool
nvm use 8.9.3 && npm update && npm i
sudo ln -s `pwd` /var/www
cd ~
sudo env PATH=$PATH:`pwd`/.nvm/versions/node/v8.9.3/bin `pwd`/.nvm/versions/node/v8.9.3/lib/node_modules/pm2/bin/pm2 startup systemd -u $CURUSER --hp `pwd`
cd ~/cryptonote-nodejs-pool
sudo chown -R $CURUSER. ~/.pm2
echo "Installing pm2-logrotate in the background!"
pm2 install pm2-logrotate 
echo "You're setup!  Please read the rest of the readme for the remainder of your setup and configuration.  These steps include: Setting your Fee Address, Pool Address, Global Domain, and the Telegram Bot setup in the config.json!"
