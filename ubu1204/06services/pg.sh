#!/bin/bash -e

sudo -u postgres /usr/lib/postgresql/9.2/bin/postgres -c config_file=/etc/postgresql/9.2/main/postgresql.conf &
sleep 5
psql -U postgres -w -f /home/shippable/setup/pg.sql
echo "=============== Added postres priviliges ===================="
sudo su - postgres -c "createuser -s --username=postgres shippable"

killall -15 postgres
