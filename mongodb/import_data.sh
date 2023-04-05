#!/bin/bash
# script that import data from the scraper into the database in MongoDB

current_date=$(date +"%m_%d_%y_data.json")
echo "$current_date"
mongoimport --host localhost -u mongoadmin -p azerty --authenticationDatabase admin --db scraper --collection listGames --file /home/brante/$current_date --jsonArray
