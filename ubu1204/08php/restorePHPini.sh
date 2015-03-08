#!/bin/bash -e
sudo su - shippable -c "cp -vr /home/shippable/.phpenv/versions/5.3/etc/.php.ini.original /home/shippable/.phpenv/versions/5.3/etc/php.ini"
sudo su - shippable -c "cp -vr /home/shippable/.phpenv/versions/5.4/etc/.php.ini.original /home/shippable/.phpenv/versions/5.4/etc/php.ini"
sudo su - shippable -c "cp -vr /home/shippable/.phpenv/versions/5.5/etc/.php.ini.original /home/shippable/.phpenv/versions/5.5/etc/php.ini"
sudo su - shippable -c "cp -vr /home/shippable/.phpenv/versions/5.6/etc/.php.ini.original /home/shippable/.phpenv/versions/5.6/etc/php.ini"

echo "=================== Increasing the php mem for all version to 1G ============="
sed -i s/"memory_limit = 128M"/"memory_limit = 1G"/g /home/shippable/.phpenv/versions/5.3/etc/php.ini
sed -i s/"memory_limit = 128M"/"memory_limit = 1G"/g /home/shippable/.phpenv/versions/5.4/etc/php.ini
sed -i s/"memory_limit = 128M"/"memory_limit = 1G"/g /home/shippable/.phpenv/versions/5.5/etc/php.ini
sed -i s/"memory_limit = 128M"/"memory_limit = 1G"/g /home/shippable/.phpenv/versions/5.6/etc/php.ini

sed -i s/"memory_limit = 128M"/"memory_limit = 1G"/g /home/shippable/.phpenv/versions/5.3/etc/.php.ini.original
sed -i s/"memory_limit = 128M"/"memory_limit = 1G"/g /home/shippable/.phpenv/versions/5.4/etc/.php.ini.original
sed -i s/"memory_limit = 128M"/"memory_limit = 1G"/g /home/shippable/.phpenv/versions/5.5/etc/.php.ini.original
sed -i s/"memory_limit = 128M"/"memory_limit = 1G"/g /home/shippable/.phpenv/versions/5.6/etc/.php.ini.original
