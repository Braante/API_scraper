#!/bin/bash
# 03/04/23
# This script will install a Flask API using with MongoDB for Metacritic games.

# Déplacement des fichiers nécessaires dans un endroit autre que le home de l'utilisateur
sudo mv ~/api /opt

# Création de l'utilisateur qui servira au scraper et changement des droits des fichiers en fonction
sudo useradd api -m -d /opt/api -s /usr/bin/nologin
sudo chgrp -R api /opt/api
sudo chown -R api /opt/api
sudo chmod u+x /opt/api/api.sh

# Installation des prérequis (python, lib python etc)
sudo dnf -y install python 
sudo dnf -y install python3-pip
sudo curl https://my-netdata.io/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh --non-interactive
sudo -u api pip install Flask
sudo -u api pip install Flask-PyMongo

# Déplacement et lancement du service et timer
sudo  mv /opt/api/api.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl start api
sudo systemctl enable api
sudo systemctl start netdata
sudo systemctl enable netdata

# Ajustement du firewall pour accéder à l'API
sudo firewall-cmd --add-port=5000/tcp --permanent
sudo firewall-cmd --add-port=19999/tcp --permanent
sudo firewall-cmd --reload