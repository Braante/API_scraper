// all command in MongoDB for the setup the solution
//
use admin
db.createUser(
{
user: "mongoadmin",
pwd: "azerty",
roles: [ { role: "userAdminAnyDatabase", db: "admin" }, "readWriteAnyDatabase" ]
}
)

use scraper

db.createUser(
{
user: "user-scraper",
pwd: "azerty",
roles: [ { role: "read", db: "scraper" }, "read" ]
}
)

db.createCollection("listGames")
