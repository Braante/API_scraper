#!/bin/bash
# The script set up the solution for backup on Backup

sudo dnf install epel-release -y
sudo curl https://my-netdata.io/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh --non-interactive

# installation de la solution de sauvegarde
sudo dnf install borgbackup -y

# création de l'utilisateur
sudo useradd backup -s /usr/bin/nologin

sudo systemctl start netdata
sudo systemctl enable netdata

# Ajustement du firewall
sudo firewall-cmd --add-port=19999/tcp --permanent
sudo firewall-cmd --reload