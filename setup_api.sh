#!/bin/bash
# 03/04/23
# This script will install a Flask API using with MongoDB for Metacritic games.

sudo mv /home/hugo/api /opt
sudo useradd api -m -d /opt/api -s /usr/bin/nologin
sudo chgrp -R api /opt/api
sudo chown -R api /opt/api
sudo chmod u+x /opt/api/api.sh
sudo dnf -y install python 
sudo dnf -y install python3-pip
sudo -u api pip install Flask
sudo -u api pip install Flask-PyMongo
sudo  mv /opt/api/api.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl start api
sudo systemctl enable api