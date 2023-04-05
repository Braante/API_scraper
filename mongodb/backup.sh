#!/bin/bash
# 01/04/23 by Brante
# This script run some command to create a backup

cd ~/
current_date=$(date +"%m-%d-%y")
borg create --stats --progress brante@10.101.1.30:/home/brante/backup::$current_date /home/brante/
