#!/bin/bash
# 03/04/23 by Brante
# This script launches the other scripts on the other machines to be able to set up the solution.

#  #############################################################################################  #
# 
#  Merci de d'avoir 4 machines disponible aux IP (statiques) suivantes:
#
#  machine MongoDB : 10.101.1.10
#  machine scraper : 10.101.1.20
#  machine backup  : 10.101.1.30
#  machine API     : 10.101.1.40
#
#  Si vous voulez changer les IP par d'autres, il faudra les modifier dans les scripts
#  directement.
#  Les machines doivent avoir un accès réseau en NAT & en réseau privé hôte.
#
#  #############################################################################################  #



echo "Quel est le nom de l'utilisateur sur la machine mongoDB ?"
read nameUserMongoDB
echo "$nameUserMongoDB" >> ./mongodb/name.txt
sudo scp -r ./mongodb $nameUserMongoDB@10.101.1.10:/home/$nameUserMongoDB/

echo "Quel est le nom de l'utilisateur sur la machine scraper ?"
read nameUserScraper
sudo scp -r ./automatisation/scraper $nameUserScraper@10.101.1.20:/home/$nameUserScraper/
sudo scp ./setup_scraper.sh $nameUserScraper@10.101.1.20:/home/$nameUserScraper/

echo "Quel est le nom de l'utilisateur sur la machine backup ?"
read nameUserBackup
sudo scp -r ./automatisation/backup $nameUserBackup@10.101.1.30:/home/$nameUserBackup/

echo "Quel est le nom de l'utilisateur sur la machine API ?"
read nameUserApi
sudo scp -r ./automatisation/api $nameUserApi@10.101.1.40:/home/$nameUserApi/
sudo scp ./setup_api.sh $nameUserApi@10.101.1.40:/home/$nameUserApi

ssh $nameUserMongoDB@10.101.1.10 /home/$nameUserMongoDB/mongodb/setup_mongodb.sh

echo "TERMINE!"
