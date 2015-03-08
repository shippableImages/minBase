#!/bin/bash

sudo /usr/bin/mysqld_safe &
sleep 5
mysqladmin -u root -p'aaa' password ''
echo "GRANT ALL ON *.* TO shippable@localhost IDENTIFIED BY ''; FLUSH PRIVILEGES;" | mysql -uroot
echo "GRANT ALL ON *.* TO travis@localhost IDENTIFIED BY ''; FLUSH PRIVILEGES;" | mysql -uroot
echo "GRANT ALL ON *.* TO travis IDENTIFIED BY ''; FLUSH PRIVILEGES;" | mysql -uroot
echo "GRANT ALL ON *.* TO ''@localhost IDENTIFIED BY ''; FLUSH PRIVILEGES;" | mysql -uroot
echo "=============== Added mysql priviliges ===================="
