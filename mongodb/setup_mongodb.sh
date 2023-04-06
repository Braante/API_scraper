#!/bin/bash
# 03/04/23
# Ce script va installer et configurer la solution MongoDB sur la machine.

sudo dnf -y install python
sudo curl https://my-netdata.io/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh --non-interactive

# installation of MongoDB
sudo mv ~/mongodb/mongodb-org-6.0.repo /etc/yum.repos.d/
sudo yum install -y mongodb-org

# running the service & enable it
sudo systemctl start mongod
sudo systemctl enable mongod

sudo mv ~/mongodb/mongod.conf /etc/

# création de l'utilisateur
sudo useradd mongodb -m -d /opt/mongodb -s /usr/bin/nologin
sudo chgrp -R mongodb /opt/mongodb
sudo chown -R mongodb /opt/mongodb
sudo chmod u+x /opt/mongodb/import_data.sh

sudo  mv ~/mongodb/mongodb.service /etc/systemd/system
sudo  mv ~/mongodb/mongodb.timer /etc/systemd/system
sudo systemctl start mongodb.timer
sudo systemctl enable mongodb.timer
sudo systemctl daemon-reload

# /up/  PARFAIT ! /up/

mongosh < ~/mongodb/mongo.js
sudo systemctl start netdata
sudo systemctl enable netdata

# Ajustement du firewall
sudo firewall-cmd --add-port=19999/tcp --permanent
sudo firewall-cmd --add-port=60000/tcp --permanent
sudo firewall-cmd --reload