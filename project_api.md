# All command

## secure MongoDB

- create database
`> use admin`

- create user
```
admin> db.createUser(
... {
... user: "root",
... pwd: "admin",
... roles: [ { role: "userAdminAnyDatabase", db: "admin" }, "readWriteAnyDatabase" ]
... }
... )
```

```
{ ok: 1 }
```

- exit MongoDb
`admin> exit`

- go to the MongoDB config file
`$ sudo vim /etc/mongod.conf`

- Edit the file by uncommenting “security” and adding the line below:
```
security:
    authorization: "enabled"
```

- restart the service to apply the edit
`sudo systemctl restart mongod`

- check the port of the service
```
$ sudo ss -alpnet

LISTEN    0         4096             127.0.0.1:27017            0.0.0.0:*        users:(("mongod",pid=2012,fd=14)) uid:990 ino:23418 sk:2 cgroup:/system.slice/mongod.service <->
```

- allow this port through the firewall
```
[brante@MongoDB ~]$ sudo firewall-cmd --zone=public --add-port=27017/tcp --permanent
success
[brante@MongoDB ~]$ sudo firewall-cmd --reload
success
```

- connection to MongoDB
```
[brante@MongoDB ~]$ mongosh --host 127.0.0.1 --port 27017 --authenticationDatabase "admin" -u "root" -p
Enter password: *****
Current Mongosh Log ID:	63f8853f723fcfff7736a803
Connecting to:		mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+1.6.2
Using MongoDB:		6.0.4
Using Mongosh:		1.6.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> 
```
