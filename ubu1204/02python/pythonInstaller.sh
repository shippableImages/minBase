#!/bin/bash -e

echo "============ install python prereqs==============";
add-apt-repository -y ppa:fkrull/deadsnakes;
apt-get update;
apt-get install python2.6 python2.6-dev python2.5 python2.5-dev python3.2 python3.2-dev python3.3 python3.3-dev python-pip python-dev python-virtualenv python3.4 python3.4-dev;

echo "========= Installing python packages ================"
sudo pip install pika pyyaml paramiko coverage nose pytest tox docopt python-daemon mock;
sudo pip install http://lxml.de/files/lxml-3.3.1pre.tar.gz;
sudo apt-get -y install python3.3-gdbm;

echo "============ downloading pypy ==============";
cd /opt && sudo wget https://bitbucket.org/pypy/pypy/downloads/pypy-2.2.1-linux64.tar.bz2 && sudo tar -xjvf pypy-2.2.1-linux64.tar.bz2;

echo "============== creating symlink for pypy ===============";
sudo ln -sf /opt/pypy-2.2.1-linux64/bin/pypy /usr/local/bin/pypy;

echo "========== Installing nose in python VEs ==========================";
sudo su - shippable -c "virtualenv -p /usr/bin/python2.5 /home/shippable/build_ve/python/2.5 && . /home/shippable/build_ve/python/2.5/bin/activate && pip install nose"
sudo su - shippable -c "virtualenv -p /usr/bin/python2.6 /home/shippable/build_ve/python/2.6 && . /home/shippable/build_ve/python/2.6/bin/activate && pip install nose"
sudo su - shippable -c "virtualenv -p /usr/bin/python2.7 /home/shippable/build_ve/python/2.7 && . /home/shippable/build_ve/python/2.7/bin/activate && pip install nose"
sudo su - shippable -c "virtualenv -p /usr/bin/python3.2 /home/shippable/build_ve/python/3.2 && . /home/shippable/build_ve/python/3.2/bin/activate && pip install nose"
sudo su - shippable -c "virtualenv -p /usr/bin/python3.3 /home/shippable/build_ve/python/3.3 && . /home/shippable/build_ve/python/3.3/bin/activate && pip install nose"
sudo su - shippable -c "virtualenv -p /usr/bin/python3.4 /home/shippable/build_ve/python/3.4 && . /home/shippable/build_ve/python/3.4/bin/activate && pip install nose"


echo "========== Installing mock in python VEs ==========================";
sudo su - shippable -c "virtualenv -p /usr/bin/python2.5 /home/shippable/build_ve/python/2.5 && . /home/shippable/build_ve/python/2.5/bin/activate && pip install mock"
sudo su - shippable -c "virtualenv -p /usr/bin/python2.6 /home/shippable/build_ve/python/2.6 && . /home/shippable/build_ve/python/2.6/bin/activate && pip install mock"
sudo su - shippable -c "virtualenv -p /usr/bin/python2.7 /home/shippable/build_ve/python/2.7 && . /home/shippable/build_ve/python/2.7/bin/activate && pip install mock"
sudo su - shippable -c "virtualenv -p /usr/bin/python3.2 /home/shippable/build_ve/python/3.2 && . /home/shippable/build_ve/python/3.2/bin/activate && pip install mock"
sudo su - shippable -c "virtualenv -p /usr/bin/python3.3 /home/shippable/build_ve/python/3.3 && . /home/shippable/build_ve/python/3.3/bin/activate && pip install mock"
sudo su - shippable -c "virtualenv -p /usr/bin/python3.4 /home/shippable/build_ve/python/3.4 && . /home/shippable/build_ve/python/3.4/bin/activate && pip install mock"


echo "========== Installing pytest in python VEs ==========================";
sudo su - shippable -c "virtualenv -p /usr/bin/python2.5 /home/shippable/build_ve/python/2.5 && . /home/shippable/build_ve/python/2.5/bin/activate && pip install pytest"
sudo su - shippable -c "virtualenv -p /usr/bin/python2.6 /home/shippable/build_ve/python/2.6 && . /home/shippable/build_ve/python/2.6/bin/activate && pip install pytest"
sudo su - shippable -c "virtualenv -p /usr/bin/python2.7 /home/shippable/build_ve/python/2.7 && . /home/shippable/build_ve/python/2.7/bin/activate && pip install pytest"
sudo su - shippable -c "virtualenv -p /usr/bin/python3.2 /home/shippable/build_ve/python/3.2 && . /home/shippable/build_ve/python/3.2/bin/activate && pip install pytest"
sudo su - shippable -c "virtualenv -p /usr/bin/python3.3 /home/shippable/build_ve/python/3.3 && . /home/shippable/build_ve/python/3.3/bin/activate && pip install pytest"
sudo su - shippable -c "virtualenv -p /usr/bin/python3.4 /home/shippable/build_ve/python/3.4 && . /home/shippable/build_ve/python/3.4/bin/activate && pip install pytest"
