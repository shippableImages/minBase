#!/bin/bash -e

mkdir -p /dev/fd/63
mkdir -p /dev/fd/62
mkdir -p /dev/fd/61

chmod -cR 777 /dev

apt-get install autotools-dev libbison-dev libsigsegv2 libtinfo-dev libyaml-0-2 udev

echo "============== Installing ruby packages =============";
sudo su - shippable -c "\\curl -L https://get.rvm.io | bash";
sudo su - shippable -c ". .rvm/scripts/rvm && rvm install 1.8.7 && rvm install 1.9.2 && rvm install 1.9.3"
sudo su - shippable -c ". .rvm/scripts/rvm && rvm install 2.0.0 && rvm install 2.1.1"

sudo su - shippable -c ". .rvm/scripts/rvm && rvm default 1.9.3 && rvm use 1.9.3 --default"
sudo su - shippable -c "echo \"[[ -s '/home/shippable/.rvm/scripts/rvm' ]] && . /home/shippable/.rvm/scripts/rvm \" | tee -a /home/shippable/.bashrc > /dev/null"

echo "============== Installing ruby gems =============";
apt-get install rake

echo "Installing jekyll";
sudo su - shippable -c "rvm use 1.9.3 && gem install jekyll --no-ri --no-rdoc";

echo "Installing bundler";
sudo su - shippable -c "rvm use 1.9.3 && gem install bundler --no-ri --no-rdoc";

echo "Installing rake";
sudo su - shippable -c "rvm use 1.9.3 && gem install rake --no-ri --no-rdoc";

sudo su - shippable -c "rm -rf ~/.m2 && rvm get head && rvm install jruby-1.7.12 --1.9 --create && rvm install jruby-1.7.12 --1.8 --create";
#sudo su - shippable -c ". .rvm/scripts/rvm && rvm install ruby-head && rvm install rbx && rvm install ree"
sudo su - shippable -c ". .rvm/scripts/rvm && rvm install ruby-head"
