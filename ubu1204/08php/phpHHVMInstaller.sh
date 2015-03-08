#!/bin/bash -e

sudo add-apt-repository ppa:mapnik/boost
wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
echo deb http://dl.hhvm.com/ubuntu precise main | sudo tee /etc/apt/sources.list.d/hhvm.list
sudo apt-get update
sudo apt-get install hhvm

mkdir -p ~/.phpenv/versions/hhvm/bin
cp /usr/bin/hhvm ~/.phpenv/versions/hhvm/bin/hhvm
ln -s ~/.phpenv/versions/hhvm/bin/hhvm ~/.phpenv/versions/hhvm/bin/php
export PATH="/home/shippable/.phpenv/bin:$PATH" && eval "$(phpenv init -)"
phpenv rehash

phpenv global hhvm

echo "==================== Installing composer in PHP hhvm ==================="
composer --version

echo "==================== Installing phpunit in PHP hhvm ==================="
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
mv phpunit.phar /home/shippable/.phpenv/versions/hhvm/bin/phpunit
phpenv rehash

echo "==================== Setting datetime in php.ini ==================="
sudo chown shippable:shippable /etc/hhvm/php.ini
echo -e "\n[Date]\ndate.timezone = \"UTC\"" >> /etc/hhvm/php.ini 

echo "==================== Backing up hhvm php.ini ==================="
sudo cp /etc/hhvm/php.ini /etc/hhvm/.php.ini.original
