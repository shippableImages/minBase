#!/bin/bash -e

mkdir -p /dev/fd/62
chmod -cR 777 /dev

echo "================= Installing gvm ==================="
apt-get install mercurial make binutils bison gcc build-essential
sudo su - shippable -c "curl -s -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash";
sudo su - shippable -c "echo '[[ -s \"/home/shippable/.gvm/scripts/gvm\" ]] && source \"/home/shippable/.gvm/scripts/gvm\"' >> /home/shippable/.bashrc";

echo "================= Installing GO 1.1 ==================="
sudo su - shippable -c "source /home/shippable/.gvm/scripts/gvm && gvm install go1.1";

echo "================= Installing GO 1.2 ==================="
sudo su - shippable -c "source /home/shippable/.gvm/scripts/gvm && gvm install go1.2";

echo "================= Installing GO release ==================="
sudo su - shippable -c "source /home/shippable/.gvm/scripts/gvm && gvm install release";

echo "================= Installing GO tip ==================="
sudo su - shippable -c "source /home/shippable/.gvm/scripts/gvm && gvm install tip";

