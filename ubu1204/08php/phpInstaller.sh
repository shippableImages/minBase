#!/bin/bash -e


echo "==================== installing phpenv ==================="
cd /tmp/ && git clone git://github.com/CHH/php-build.git php-build-install && cd php-build-install && sudo ./install.sh;
sudo su - shippable -c "mkdir -p /home/shippable/bin && rm -rf /home/shippable/bin/phpenv && rm -rf /home/shippable/.phpenv"
sudo su - shippable -c "cd /home/shippable/bin && git clone https://github.com/CHH/phpenv.git && phpenv/bin/phpenv-install.sh";

echo "===================== updating bashrc ====================="
sudo su - shippable -c "echo \"export PATH='/home/shippable/.phpenv/bin:$PATH'\" | tee -a /home/shippable/.bashrc > /dev/null";

sudo chown -cR shippable:shippable /usr/local/share/php-build

echo "===================== Installing build dependencies for PHP extensions ====================="
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y bzip2 libgmp-dev openssl libssl-dev libpam0g-dev libicu-dev

echo "===================== Installing c-client for PHP IMAP extension ====================="
mkdir -p /home/shippable/setup/php
cd /home/shippable/setup/php
wget ftp://ftp.cac.washington.edu/imap/c-client.tar.Z
tar xvf c-client.tar.Z
cd imap-2007f
yes 'y' | make lnp SSLTYPE=unix SSLINCLUDE=/usr/include/openssl

# Deploy IMAP c-client to /usr/local
sudo mkdir -p /usr/local/imap-2007f/lib /usr/local/imap-2007f/include
cd c-client
sudo cp *.h /usr/local/imap-2007f/include/
sudo cp *.c /usr/local/imap-2007f/lib/
sudo cp c-client.a /usr/local/imap-2007f/lib/libc-client.a
sudo chown -R shippable:shippable /home/shippable/setup/php

# Create soft links so PHP can find the kerberos libs
sudo mkdir -p /usr/kerberos
sudo ln -s /usr/lib/x86_64-linux-gnu/ /usr/kerberos/lib
sudo ln -s /usr/lib/x86_64-linux-gnu/ /usr/kerberos/lib64

install_php_with_pear() {
  echo "==================== Installing PHP $1 ==================="
  # LDFLAGS is to get around issues with compiling PHP with intl enabled
  # CONFIGURE_OPTS is used by php-build to pass compile options to PHP
  sudo su - shippable -c "LDFLAGS=\"-lstdc++\" CONFIGURE_OPTS=\"--with-bz2 --enable-calendar --with-gettext=/usr/bin --with-gmp --with-pdo-pgsql --with-pgsql --enable-sysvmsg --with-imap=/home/shippable/setup/php/imap-2007f --with-imap-ssl --enable-intl\" php-build --pear $1 /home/shippable/.phpenv/versions/$1"

  echo "==================== Updating php.ini in PHP $1 ==================="
  echo -e "\n[Date]\ndate.timezone = \"UTC\"" >> /home/shippable/.phpenv/versions/$1/etc/php.ini
  sed -i "s/;phar.readonly\ =\ On/phar.readonly\ =\ Off/1" /home/shippable/.phpenv/versions/$1/etc/php.ini
  
  echo "==================== Creating backup of php.ini in PHP $1 ==================="
  cp /home/shippable/.phpenv/versions/$1/etc/php.ini /home/shippable/.phpenv/versions/$1/etc/.php.ini.original
}

PHP_5_3="5.3.28"
PHP_5_4="5.4.30"
PHP_5_5="5.5.14"
PHP_5_6="5.6.0"

install_php_with_pear $PHP_5_3
install_php_with_pear $PHP_5_4
install_php_with_pear $PHP_5_5
install_php_with_pear $PHP_5_6

echo "==================== Setting up short version links ==================="
sudo su - shippable -c "ln -s /home/shippable/.phpenv/versions/$PHP_5_3 /home/shippable/.phpenv/versions/5.3"
sudo su - shippable -c "ln -s /home/shippable/.phpenv/versions/$PHP_5_4 /home/shippable/.phpenv/versions/5.4"
sudo su - shippable -c "ln -s /home/shippable/.phpenv/versions/$PHP_5_5 /home/shippable/.phpenv/versions/5.5"
sudo su - shippable -c "ln -s /home/shippable/.phpenv/versions/$PHP_5_6 /home/shippable/.phpenv/versions/5.6"

echo "==================== Resetting permissions on /tmp/pear ==================="
sudo chown -R shippable:shippable /tmp/pear

