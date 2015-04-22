#!/bin/bash -e

echo "installing appbase dependencies"
sudo pip install awscli==1.7.20
sudo pip install glob2==0.4.1
sudo pip install pika==0.9.14

echo "true" | sudo tee /deps_updated.txt
