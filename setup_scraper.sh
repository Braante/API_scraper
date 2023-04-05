#!/bin/bash
# 03/04/23
# This script will install a scraper for MetaCritic games.
sudo mv /home/hugo/scraper /opt
sudo useradd scraper -m -d /opt/scraper -s /usr/bin/nologin
sudo chgrp -R scraper /opt/scraper
sudo chown -R scraper /opt/scraper
sudo chmod u+x /opt/scraper/scraper.sh
sudo dnf -y install python 
sudo dnf -y install python3-pip
sudo -u scraper pip install requests
sudo -u scraper pip install beautifulsoup4
sudo -u scraper pip install threaded
sudo  mv /opt/scraper/scraper.service /etc/systemd/system
sudo  mv /opt/scraper/scraper.timer /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl start scraper.timer
sudo systemctl enable scraper.timer
