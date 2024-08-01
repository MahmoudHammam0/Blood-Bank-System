#!/usr/bin/python3
"Hospital table module"
from models.base_model import BaseModel, Base
from sqlalchemy import Column, String, ForeignKey
from sqlalchemy.orm import relationship
import bcrypt


class Hospital(BaseModel, Base):
    "Hospital table"
    __tablename__ = "hospitals"

    name = Column(String(60), nullable=False)
    hashed_password = Column(String(128), nullable=False)
    city_id = Column(String(60), ForeignKey('cities.id'), nullable=False)
    patients = relationship("Patient", cascade="all, delete-orphan", backref="hospital")
    requests = relationship("Request", cascade="all, delete-orphan", backref="hospital")



    @property
    def password(self):
        "getter for hashed_password"
        return self.hashed_password
    
    @password.setter
    def password(self, password):
        "setter for hashing the password"
        encoded_password = password.encode('utf-8')
        salt = bcrypt.gensalt()
        self.hashed_password = bcrypt.hashpw(encoded_password, salt)

    def check_password(self, password_to_check):
        "check the hashed password for login"
        return bcrypt.checkpw(password_to_check.encode('utf-8'), self.hashed_password)