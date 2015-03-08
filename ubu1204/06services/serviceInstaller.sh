#!/bin/bash -e
echo "================= Installing clang ===================="
sudo apt-get install clang;

echo "===================== Setting mysql defaults ==============================="
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password aaa'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password aaa'
sudo apt-get install mysql-server

echo "================= Installing PostGRE ===================="
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list ;
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update;
apt-get install postgresql-9.3 postgresql-contrib-9.3 postgresql-client-9.3 postgresql-9.3-postgis-2.1
apt-get install postgresql-9.2 postgresql-contrib-9.2 postgresql-client-9.2 postgresql-9.2-postgis-2.1
apt-get install postgresql-9.1 postgresql-contrib-9.1 postgresql-client-9.1 postgresql-9.1-postgis-2.1


echo "========== Updating port numbers in Postgre 9.1 and 9.2 config files ==============";
sudo sed -i "s/port\ =\ 5434/port\ =\ 5432/1" /etc/postgresql/9.1/main/postgresql.conf;
sudo sed -i "s/port\ =\ 5433/port\ =\ 5432/1" /etc/postgresql/9.2/main/postgresql.conf;

echo "========== Updating permissions file for PG 9.1 and 9.3 ==========================";
sudo cp -vr /etc/postgresql/9.2/main/pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf
sudo cp -vr /etc/postgresql/9.2/main/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf


echo "================= Installing SQL Lite ===================="
apt-get install libcurl4-gnutls-dev libsqlite3-dev libmagickwand-dev libmysqlclient-dev;
apt-get install sqlite sqlite3

echo "============ Installing mongodb ==============="
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10;
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list;
apt-get update -y;
apt-get -y install --force-yes mongodb-10gen && mkdir -p /data/db/;

echo "=============== Installing neo4j ===================";
wget -O - http://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add - ;
echo 'deb http://debian.neo4j.org/repo stable/' | sudo tee -a /etc/apt/sources.list.d/neo4j.list;
apt-get update -y;
apt-get -yy install neo4j --force-yes;

echo "============== Installing cassandra ==================";
echo "deb http://www.apache.org/dist/cassandra/debian 21x main" | sudo tee -a /etc/apt/sources.list;
echo "deb-src http://www.apache.org/dist/cassandra/debian 21x main" | sudo tee -a /etc/apt/sources.list;

gpg --keyserver pgp.mit.edu --recv-keys F758CE318D77295D
gpg --export --armor F758CE318D77295D | sudo apt-key add -
gpg --keyserver pgp.mit.edu --recv-keys 2B5C1B00
gpg --export --armor 2B5C1B00 | sudo apt-key add -
gpg --keyserver pgp.mit.edu --recv-keys 0353B12C
gpg --export --armor 0353B12C | sudo apt-key add -

sudo apt-get update;
sudo apt-get -yy install cassandra --force-yes;

echo "============== Rethink DB ==================";
# Reinstall using instructions from http://rethinkdb.com/docs/install/ubuntu/
source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
wget -qO- http://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install rethinkdb
rethinkdb --version

echo "============== Couch DB ==================";
sudo add-apt-repository ppa:couchdb/stable -y
sudo apt-get update -y
# remove any existing couchdb binaries
sudo apt-get remove couchdb couchdb-bin couchdb-common -yf
sudo apt-get install -V couchdb

echo "========== Creating run dir for Couchdb ===============";
sudo mkdir -p /var/run/couchdb;

echo "================ Installing selenium =================="
sudo mkdir -p /srv;
cd /srv && sudo wget http://selenium.googlecode.com/files/selenium-server-standalone-2.35.0.jar;

echo "============== Installing rabbitmq ==========="
echo "=========== PreReq Erlang =============="
cd /tmp && wget http://packages.erlang-solutions.com/erlang/esl-erlang/FLAVOUR_1_general/esl-erlang_16.b.2-1~ubuntu~precise_amd64.deb;
sudo dpkg -i esl-erlang_16.b.2-1~ubuntu~precise_amd64.deb;

echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list;
wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc;
sudo apt-key add rabbitmq-signing-key-public.asc;
apt-get update;
sudo apt-get install rabbitmq-server;

echo "===================== Installing Redis ================================"
sudo add-apt-repository -y ppa:chris-lea/redis-server
sudo apt-get update
sudo apt-get install -y -o Dpkg::Options::="--force-confold" redis-server

echo "===================== Installing Memcache ================================"
apt-get install memcached;

echo "========= Installing elasticsearch ==================="
cd /tmp && wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.deb && sudo dpkg -i elasticsearch-1.1.1.deb && sudo rm -f elasticsearch-1.1.1.deb;

echo "================ Installing browsers ====================="
sudo apt-get install firefox chromium-browser;
sudo ln -s /usr/bin/chromium-browser /usr/bin/chrome;
sudo apt-get -f install;

wget -q -O- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# removing this as its creating a duplicate entry
# sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable

wget -q -O-  http://deb.opera.com/archive.key | sudo apt-key add -
sudo sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" > /etc/apt/sources.list.d/opera.list'
sudo apt-get update
sudo apt-get install -y opera

echo "================ Installing RIAK ====================="
curl http://apt.basho.com/gpg/basho.apt.key | sudo apt-key add -
sudo bash -c "echo deb http://apt.basho.com $(lsb_release -sc) main > /etc/apt/sources.list.d/basho.list"
sudo apt-get update
sudo apt-get install riak
