#!/usr/bin/python3
"Blood bank table module"
from models.base_model import BaseModel, Base
from sqlalchemy import Column, String, ForeignKey
from sqlalchemy.orm import relationship
import bcrypt


class BloodBank(BaseModel, Base):
    "blook_bank table"
    __tablename__ = "blood_banks"

    name = Column(String(60), nullable=False)
    hashed_password = Column(String(128), nullable=False)
    city_id = Column(String(60), ForeignKey('cities.id'), nullable=False)
    stocks = relationship("BloodStock", cascade="all, delete-orphan", backref="blood_bank")


    @property
    def password(self):
        "Getter for hashed_password"
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