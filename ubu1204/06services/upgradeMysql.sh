#!/bin/bash -e

echo "=========== Downloading mysql 5.6 ==============="
cd /tmp && wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.15-debian6.0-x86_64.deb -O mysql-5.6.15-debian6.0-x86_64.deb;
echo "=========== Installing mysql 5.6 ==============="
dpkg -i  mysql-5.6.15-debian6.0-x86_64.deb;
rm mysql-5.6.15-debian6.0-x86_64.deb

ech "============ Removing mysql 5.5 ================="
apt-get -y remove mysql-server mysql-server-5.5 mysql-server-core-5.5

apt-get install libaio1

chown -R mysql /opt/mysql/server-5.6/
chgrp -R mysql /opt/mysql/server-5.6/

ln -sf /opt/mysql/server-5.6/bin/mysqld_safe /usr/bin/mysqld_safe
