#!/usr/bin/python3
"blood group table module"
from models.base_model import BaseModel, Base
from sqlalchemy import Column, String
from sqlalchemy.orm import relationship


class BloodGroup(BaseModel, Base):
    "blood group table"
    __tablename__ = "blood_groups"

    type = Column(String(60), nullable=False, unique=True)
    donations = relationship("BloodDonation", cascade="all, delete-orphan", backref="blood_group")
    stocks = relationship("BloodStock", cascade="all, delete-orphan", backref="blood_group")
    requests = relationship("Request", cascade="all, delete-orphan", backref="blood_group")
    