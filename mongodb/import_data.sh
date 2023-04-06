#!/bin/bash
# script that import data from the scraper into the database in MongoDB


python /opt/mongodb/ssl_client.py
current_date=$(date +"%m_%d_%y_data.json")
echo "$current_date"
mongoimport --host localhost -u mongoadmin -p azerty --authenticationDatabase admin --db scraper --collection listGames --file /opt/mongodb/$current_date --jsonArray