#!/bin/bash
# 03/04/23
# Ce script va installer et configurer la solution MongoDB sur la machine.

# installation of MongoDB
sudo mv ~/mongodb/mongodb-org-6.0.repo /etc/yum.repos.d/
sudo yum install -y mongodb-org

# running the service & enable it
sudo systemctl start mongod
sudo systemctl enable mongod

sudo rm -r /etc/mongod.conf
sudo mv ~/mongodb/mongod.conf /etc/

# création de l'utilisateur
sudo useradd mongodb -s /usr/bin/nologin

# /up/  PARFAIT ! /up/

mongosh < ~/mongodb/mongo.js

