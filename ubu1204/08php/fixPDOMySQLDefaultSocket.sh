#!/bin/bash -e

sed -i 's/^pdo_mysql.default_socket=$/pdo_mysql.default_socket=\/var\/run\/mysqld\/mysqld.sock/g' /home/shippable/.phpenv/versions/*/etc/php.ini
sed -i 's/^pdo_mysql.default_socket=$/pdo_mysql.default_socket=\/var\/run\/mysqld\/mysqld.sock/g' /home/shippable/.phpenv/versions/*/etc/.php.ini.original
