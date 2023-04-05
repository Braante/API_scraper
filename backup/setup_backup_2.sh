#!/bin/bash
# The script set up the solution for backup on Backup

# mettre à jour les paquets
sudo dnf update -y

# 
sudo dnf install epel-release -y

# installation de la solution de sauvegarde
sudo dnf install borgbackup -y

# création de l'utilisateur
useradd backup -s /usr/bin/nologin
