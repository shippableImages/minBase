#!/bin/bash -e

# This whole script needs to be run as the shippable user. Do not wrap this up 
# into some other installer script. Run it separately straight from the Dockerfile
# with `sudo su - shippable`

export PATH="/home/shippable/.phpenv/bin:$PATH" && eval "$(phpenv init -)"


curl -sS https://getcomposer.org/installer | php;

sudo mv composer.phar /usr/local/bin/composer;
sudo chown -cR shippable:shippable /usr/local/bin/composer;


echo "==================== Installing phpenv composer plugin ==================="
mkdir /home/shippable/.phpenv/plugins && cd /home/shippable/.phpenv/plugins
git clone https://github.com/ngyuki/phpenv-composer.git
phpenv rehash

install_composer_and_phpunit() {
  echo "==================== Installing composer in PHP $1 ==================="
  phpenv global $1
  phpenv rehash

  # Yes, this really does install composer. The phpenv-composer plugin that
  # we installed above creates a shim for composer that will download it the 
  # first time it's used.
  composer --version 

  echo "==================== Installing phpunit in PHP $1 ==================="
  wget https://phar.phpunit.de/phpunit.phar
  chmod +x phpunit.phar
  mv phpunit.phar /home/shippable/.phpenv/versions/$1/bin/phpunit
  phpenv rehash
}

install_composer_and_phpunit 5.3
install_composer_and_phpunit 5.4
install_composer_and_phpunit 5.5
install_composer_and_phpunit 5.6

