#!/usr/bin/python3
"donor table module"
from models.base_model import BaseModel, Base
from sqlalchemy import Column, String, ForeignKey
from sqlalchemy.orm import relationship
from flask_login import UserMixin


class Donor(BaseModel, Base, UserMixin):
    "Donor table"
    __tablename__ = "donors"

    name = Column(String(60), nullable=False)
    national_id = Column(String(60), unique=True, nullable=False)
    blood_group_id = Column(String(60), ForeignKey("blood_groups.id"), nullable=False)
    email = Column(String(60), unique=True, nullable=False)
    city_id = Column(String(60), ForeignKey("cities.id"), nullable=False)
    donations = relationship("BloodDonation", cascade="all, delete-orphan", backref="donor")
