#!/usr/bin/python3
"intialization of the DBStorage class and reload of the db"
from models.db_engine.db_storage import DBStorage


db = DBStorage()
db.db_reload()