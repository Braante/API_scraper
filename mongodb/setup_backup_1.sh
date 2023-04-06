#!/bin/bash
# Ce script met en place la solution pour la sauvegarde sur la machine MongoDB

# installation du paquet epel-release au cas où il ne soit pas installer
sudo dnf install epel-release -y

# installation de la solution de sauvegarde
sudo dnf install borgbackup -y

# lecture du fichier txt pour récupérer le nom de l'utilisateur
name=`cat ./name.txt`

# configuration de l'environnement de sauvegarde à distance sur la machine en question
borg init --encryption=none $name@10.101.1.30:/home/brante/backup

# gestion des droits sur les nouveaux fichiers
sudo chown mongodb backup.service
sudo chgrp mongodb backup.service
sudo chown mongodb backup.timer
sudo chgrp mongodb backup.timer
sudo chown mongodb backup.sh
sudo chgrp mongodb backup.sh

# déplacement du service, du timer et du script
sudo mv backup.service /etc/systemd/system/
sudo mv backup.timer /etc/systemd/system/
sudo mkdir /opt/backup
sudo mv backup.sh /opt/backup/

# activation (aussi dès le démarrage) du service et du timer
sudo systemctl start backup.timer
sudo systemctl enable backup.timer

