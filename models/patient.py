#!/usr/bin/python3
"patient table module"
from models.base_model import BaseModel, Base
from sqlalchemy import Column, String, ForeignKey


class Patient(BaseModel, Base):
    "patient table class"
    __tablename__ = "patients"

    name = Column(String(60), nullable=False)
    hospital_id = Column(String(60), ForeignKey("hospitals.id"), nullable=False)
    blood_group_id = Column(String(60), ForeignKey("blood_groups.id"), nullable=False)
    status = Column(String(60), nullable=False)
