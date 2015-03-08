#!/bin/bash -e
dpkg-divert --local --rename --add /sbin/initctl;
ln -s /bin/true /sbin/initctl;
echo "en_US.UTF-8 UTF-8" >> /var/lib/locales/supported.d/local;
locale-gen en_US en_US.UTF-8;
dpkg-reconfigure locales;

apt-get update;
apt-get install libssl1.0.0 openssl libssl-dev;
apt-get install wget curl g++ texinfo make vim openssh-server gdb git-core;
apt-get install supervisor sudo python-pip nano;

pip install -I virtualenv==1.11.4

echo "========== enabling 'add-apt-repository' command ============"
apt-get install python-software-properties;

echo "===========Node PreReqs ================="
sudo su - shippable -c "\\curl https://raw.githubusercontent.com/creationix/nvm/v0.17.1/install.sh | bash"

apt-get install xvfb libfontconfig1 build-essential chrpath

apt-get install libxslt-dev libxml2-dev libpq5 libpq-dev git git-core;
apt-get install rake zlib1g-dev libyaml-dev libssl-dev libreadline-dev libncurses5-dev bison ruby-dev supervisor;
apt-get install gawk libreadline6-dev autoconf libgdbm-dev automake libtool libffi-dev libsasl2-dev maven ;
apt-get install libxslt-dev libxml2-dev libevent-dev chrpath libfontconfig1-dev libqt4-core libqt4-dev libqt4-gui;
apt-get install x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps libmagickwand-dev;
apt-get install imagemagick qt4-dev-tools;

echo "=================== php dependencies ====================="
sudo apt-get install libxml2-dev libpcre3-dev libbz2-dev libcurl4-openssl-dev libdb4.8-dev libjpeg-dev libpng12-dev;
sudo apt-get install libxpm-dev libfreetype6-dev libmysqlclient-dev libt1-dev;
sudo apt-get install libgd2-xpm-dev libgmp-dev libsasl2-dev libmhash-dev;
sudo apt-get install unixodbc-dev freetds-dev libpspell-dev libsnmp-dev libtidy-dev libxslt1-dev libmcrypt-dev;

echo "========= Installing FUSE ==================="
apt-get install fuse  || :;
rm -rf /var/lib/dpkg/info/fuse.postinst && apt-get install fuse;

echo "========= Adding backports =================="
echo "deb http://archive.ubuntu.com/ubuntu precise-backports main universe" | sudo tee -a /etc/apt/sources.list
sudo apt-get update

echo "==================== Upgrading git ==================="
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install -y git

echo "================== Adding empty known hosts file =============="
sudo su - shippable -c "touch .ssh/known_hosts"

echo "================= updating git username and email ================="
sudo su shippable -c "git config --global user.name  \"Shippable\""
sudo su shippable -c "git config --global user.email \"hello@shippable.com\""
