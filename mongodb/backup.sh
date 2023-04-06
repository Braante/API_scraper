#!/bin/bash
# 01/04/23 by Brante
# This script run some command to create a backup

cd ~/
current_date=$(date +"%m_%d_%y_data.json")
name=`cat ~/mongodb/name_backup.txt`
borg create --stats --progress $name@10.101.1.30:/home/$name/backup_data::$current_date /home/$name/
