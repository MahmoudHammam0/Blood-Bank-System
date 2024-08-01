#!/usr/bin/python3
"city table module"
from models.base_model import Base, BaseModel
from sqlalchemy import Column, String
from sqlalchemy.orm import relationship


class City(BaseModel, Base):
    "city table"
    __tablename__ = "cities"

    name = Column(String(60), nullable=False)
    blood_banks = relationship("BloodBank", cascade="all, delete-orphan", backref="city")
    donors = relationship("Donor", cascade="all, delete-orphan", backref="city")
    hospitals = relationship("Hospital", cascade="all, delete-orphan", backref="city")