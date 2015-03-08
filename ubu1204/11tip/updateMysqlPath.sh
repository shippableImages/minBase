#!/bin/bash -e
ln -sf /opt/mysql/server-5.6/bin/* /usr/local/sbin
ln -sf /var/run/mysqld/mysqld.sock /tmp/mysql.sock
