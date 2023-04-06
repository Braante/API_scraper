#!/bin/bash
# 03/04/23
# Ce script va installer et configurer la solution MongoDB sur la machine.

sudo dnf -y install python

# installation of MongoDB
sudo mv ~/mongodb/mongodb-org-6.0.repo /etc/yum.repos.d/
sudo yum install -y mongodb-org

# running the service & enable it
sudo systemctl start mongod
sudo systemctl enable mongod
#sudo systemctl stop mongod

#sudo rm -r /etc/mongod.conf
sudo mv ~/mongodb/mongod.conf /etc/

#sudo systemctl start mongod

# création de l'utilisateur
sudo useradd mongodb -s /usr/bin/nologin

# /up/  PARFAIT ! /up/

mongosh < ~/mongodb/mongo.js

sh ~/mongodb/import_data.sh

