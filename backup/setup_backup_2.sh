#!/bin/bash
# The script set up the solution for backup on Backup

sudo dnf install epel-release -y

# installation de la solution de sauvegarde
sudo dnf install borgbackup -y

# création de l'utilisateur
sudo useradd backup -s /usr/bin/nologin
