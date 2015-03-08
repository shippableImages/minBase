#!/bin/bash -e
echo "================== Installing CLOJURE ====================";
sudo su - shippable -c "mkdir -p /home/shippable/bin";
sudo su - shippable -c "cd /home/shippable/bin && wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && chmod +x lein";
sudo su - shippable -c "cd /home/shippable/bin && cp lein lein2"
sudo su - shippable -c "echo 'export PATH=$PATH:/home/shippable/bin' | tee -a /home/shippable/.bashrc"

