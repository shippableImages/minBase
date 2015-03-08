#!/bin/bash -e

echo "===========Installing nodejs ================="
sudo su - shippable -c ". /home/shippable/.nvm/nvm.sh && nvm install 0.10"
sudo su - shippable -c ". /home/shippable/.nvm/nvm.sh && nvm install 0.8"
sudo su - shippable -c ". /home/shippable/.nvm/nvm.sh && nvm install 0.6"
sudo su - shippable -c ". /home/shippable/.nvm/nvm.sh && nvm install 0.11"

echo "================= Updating nvm default ==================="
sudo su - shippable -c ". /home/shippable/.nvm/nvm.sh && nvm alias default 0.10"

echo "================= Updating Ubuntu nodejs ==================="
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs
sudo npm install -g grunt-cli mocha vows phantomjs casperjs;

echo "================ Upgrading selenium =================="
sudo mkdir -p /srv;
cd /srv && sudo wget http://selenium-release.storage.googleapis.com/2.40/selenium-server-standalone-2.40.0.jar;

echo "=============== Installing bower globally ============="
sudo npm install -g bower
