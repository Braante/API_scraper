#!/bin/bash
# 03/04/23
# This script will install a scraper for MetaCritic games.

# Déplacement des fichiers nécessaires dans un endroit autre que le home de l'utilisateur
sudo mv ~/scraper /opt

# Création de l'utilisateur qui servira au scraper et changement des droits des fichiers en fonction
sudo useradd scraper -m -d /opt/scraper -s /usr/bin/nologin
sudo chgrp -R scraper /opt/scraper
sudo chown -R scraper /opt/scraper
sudo chmod u+x /opt/scraper/scraper.sh

# Installation des prérequis (python, lib python etc)
sudo dnf -y install python 
sudo dnf -y install python3-pip
sudo curl https://my-netdata.io/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh --non-interactive
sudo -u scraper pip install requests
sudo -u scraper pip install beautifulsoup4
sudo -u scraper pip install threaded

# Déplacement et lancement du service et timer
sudo  mv /opt/scraper/scraper.service /etc/systemd/system
sudo  mv /opt/scraper/scraper.timer /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl start scraper.timer
sudo systemctl enable scraper.timer
sudo systemctl start netdata
sudo systemctl enable netdata

# Ajustement du firewall
sudo firewall-cmd --add-port=19999/tcp --permanent
sudo firewall-cmd --reload

nameUserMongoDB=`cat ~/name.txt`
echo $nameUserMongoDB

# Lancement du scraper via son service
sudo systemctl start scraper

current_date=$(date +"%m_%d_%y_data.json")
sudo scp -r /opt/scraper/$current_date $nameUserMongoDB@10.101.1.10:/home/$nameUserMongoDB/mongodb