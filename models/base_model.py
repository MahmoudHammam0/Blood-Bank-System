#!/usr/bin/python3
"BaseModel class module that will be inherted by other classes"
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, String, DateTime
from datetime import datetime
import models
import uuid

Base = declarative_base()

class BaseModel:
    "Defines all common attributes/methods for other classes"
    id = Column(String(60), primary_key=True, default=lambda: str(uuid.uuid4()))
    created_at = Column(DateTime, nullable=False, default=datetime.utcnow)
    updated_at = Column(DateTime, nullable=False, default=datetime.utcnow, onupdate=datetime.utcnow)

    def __init__(self, **kwargs):
        "constructor for instances"
        if kwargs:
            for key, value in kwargs.items():
                if key != '__class__':
                    if key in ['created_at', 'updated_at']:
                        setattr(self, key, datetime.fromisoformat(value))
                    else:
                        setattr(self, key, value)
        if 'id' not in kwargs:
            self.id = str(uuid.uuid4())
        if 'created_at' not in kwargs:
            self.created_at = datetime.utcnow()
        if 'updated_at' not in kwargs:
                self.updated_at = datetime.utcnow()

    def __str__(self):
        "how should the object be printed"
        new_dict = {}
        for key, value in self.__dict__.items():
            if key != '_sa_instance_state' and key != 'created_at' and key != 'updated_at':
                new_dict[key] = value
        return ("[{}] ({}) {}".format(self.__class__.__name__, self.id, new_dict))
    
    def save(self):
        "update attribute updated_at"
        self.updated_at = datetime.utcnow()
        models.db.new(self)
        models.db.save()

    def to_dict(self):
        "returns a dictionary containing all keys/values of the instance"
        the_dict = self.__dict__.copy()
        if '_sa_instance_state' in the_dict:
            del the_dict['_sa_instance_state']
        the_dict['created_at'] = the_dict['created_at'].isoformat()
        the_dict['updated_at'] = the_dict['updated_at'].isoformat()
        the_dict['__class__'] = self.__class__.__name__
        return the_dict
    
    def delete(self):
        "deletes the current instance from the storage"
        models.db.delete(self)