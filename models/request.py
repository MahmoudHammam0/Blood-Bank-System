#!/usr/bin/python3
"request table module"
from models.base_model import BaseModel, Base
from sqlalchemy import Column, String, Integer, ForeignKey, DateTime
from datetime import datetime


class Request(BaseModel, Base):
    "request table"
    __tablename__ = "requests"

    quantity_required = Column(Integer, nullable=False)
    hospital_id = Column(String(60), ForeignKey('hospitals.id'), nullable=False)
    blood_group_id = Column(String(60), ForeignKey("blood_groups.id"), nullable=False)
    patient_status = Column(String(60), nullable=False)
    fulfilment_status = Column(String(60), nullable=True, default="")
    request_date = Column(DateTime, default=lambda: datetime.utcnow())