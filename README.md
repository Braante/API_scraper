# The Scraper project

## What is this ?

Our project recovers video games data from the `metacritic` site.
Then, stored them in a database to create a working API from them.

## How to install ?

Before the installation :
- clone the project on your computer (or host) with the command `git clone [...]`
- have 4 machines running
    - with different ips
    - in the same network
- you can retrieve IPs marked in the launch script or here : 
    - 10.101.1.10 (Database)
    - 10.101.1.20 (Scraper)
    - 10.101.1.30 (Backup)
    - 10.101.1.40 (API)
    or put any IP but it will be necessary to modify those of the script

- It's better if you use ssh keys between machines.

The installation :
- In API_scraper directory, you only need to run the script
    - `sh project_launch.sh`
- the name of the users of the machines when requested
- put the password of your machines if requested

Accessing the API on : 10.101.1.40:5000 by default (add /help for all requests possibles.)

## The different possibilities

- Backup (Borg)
    > You can perform database backups manually once a day using the command `sh /opt/backup/backup.sh` on mongodb machine. For more backup per day, you have to modify backup.sh .

    > For restore data, you can use this command on backup machine : `borg extract --dry-run -v --list backup_data/::[m_d_y]` with the correct information date.

    > For more information on backup, you can use this command on backup machine : `borg info /backup_data::[m_d_y]` with the correct information date.

- Update data now
    > If you want to update the data on the api at the moment without waiting automatic launch (at 4 am by default). You can launch `import_data.sh` in mongodb machine and after launch `scraper.sh` on scraper machine.

- Monitoring (NetData)
    > You can access on all machines at NetData Website interface on IP:19999

---

Directed by Bourmaud Hugo and Porte Brandon.