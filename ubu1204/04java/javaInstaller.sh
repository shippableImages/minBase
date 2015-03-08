#!/bin/bash -e

echo "================ java prereqs ================="
echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections;
echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections;
add-apt-repository ppa:webupd8team/java;
apt-get update;
apt-get install oracle-java7-installer oracle-java8-installer openjdk-6-jdk openjdk-7-jdk;

echo "================ Installing gradle ================="
sudo add-apt-repository -y ppa:cwchien/gradle;
sudo apt-get update;
sudo apt-get -y install gradle;

echo "=============== Installing maven ==================="
echo "deb http://ppa.launchpad.net/natecarlson/maven3/ubuntu precise main" | sudo tee -a /etc/apt/sources.list;
echo "deb-src http://ppa.launchpad.net/natecarlson/maven3/ubuntu precise main" | sudo tee -a /etc/apt/sources.list;
sudo apt-get update;
sudo apt-get install -y maven3;
sudo ln -sf /usr/share/maven3/bin/mvn /usr/bin/mvn;
