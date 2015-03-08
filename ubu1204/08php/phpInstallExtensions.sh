#!/bin/bash -e

export PATH="/home/shippable/.phpenv/bin:$PATH" && eval "$(phpenv init -)"

install_extension() {
  echo "==================== Installing PHP extension $1 to version $2 ==================="
  phpenv global $2
  mkdir -p ~/setup/php_modules && cd ~/setup/php_modules/
  if [[ $1 == memcached* ]]
  then
    # memcached is special because we need to pass --disable-memcached-sasl to configure
    # but there doesn't seem to be a way to do this with pecl options
    pecl download $1
    tar xvf $1.tgz
    cd $1
    phpize
    ./configure --disable-memcached-sasl
    make clean && make && make install
  else
    yes '' | pecl install $1
  fi
}

# apc
install_extension apc-3.1.13 5.3
install_extension apc-3.1.13 5.4
# apc is not compatible with PHP 5.5+ so we do not even try

# Introduce an additional config setting to get around incompatibility
# between apc.enable_cli and composer
sudo /bin/bash -c "echo -e \"\napc.cache_by_default=0\" >> /home/shippable/.phpenv/versions/5.3.8/etc/.php.ini.original"
sudo /bin/bash -c "echo -e \"\napc.cache_by_default=0\" >> /home/shippable/.phpenv/versions/5.4.9/etc/.php.ini.original"
sudo /bin/bash -c "echo -e \"\napc.cache_by_default=0\" >> /home/shippable/.phpenv/versions/5.5.9/etc/.php.ini.original"
sudo /bin/bash -c "echo -e \"\napc.cache_by_default=0\" >> /home/shippable/.phpenv/versions/5.6.0beta2/etc/.php.ini.original"

# memcache
install_extension memcache-3.0.8 5.3
install_extension memcache-3.0.8 5.4
install_extension memcache-3.0.8 5.5
install_extension memcache-3.0.8 5.6

# memcached
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libmemcached-dev
install_extension memcached-2.2.0 5.3
install_extension memcached-2.2.0 5.4
install_extension memcached-2.2.0 5.5
install_extension memcached-2.2.0 5.6

# mongo
install_extension mongo-1.5.3 5.3
install_extension mongo-1.5.3 5.4
install_extension mongo-1.5.3 5.5
install_extension mongo-1.5.3 5.6

# amqp
  #amqp dependencies
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y librabbitmq-dev
  mkdir -p ~/setup/php_modules/amqp && cd ~/setup/php_modules/amqp
  git clone https://github.com/alanxz/rabbitmq-c
  cd rabbitmq-c
  git submodule init && git submodule update
  autoreconf -i && ./configure && make && sudo make install
install_extension amqp-1.4.0 5.3
install_extension amqp-1.4.0 5.4
install_extension amqp-1.4.0 5.5
install_extension amqp-1.4.0 5.6
cd ~/setup/php_modules && rm -rf ~/setup/php_modules/amqp # Cleanup

# zmq
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libzmq-dev
install_extension zmq-1.1.2 5.3
install_extension zmq-1.1.2 5.4
install_extension zmq-1.1.2 5.5
install_extension zmq-1.1.2 5.6

# xdebug is already installed by default

# redis
install_extension redis-2.2.5 5.3
install_extension redis-2.2.5 5.4
install_extension redis-2.2.5 5.5
install_extension redis-2.2.5 5.6

# Assuming $HOME/bin/phpenv is already present from 08php
cp -r /home/shippable/bin/phpenv/extensions /home/shippable/.phpenv/extensions
