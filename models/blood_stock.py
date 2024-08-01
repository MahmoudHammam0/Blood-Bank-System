#!/usr/bin/python3
"Blood Stock table module"
from models.base_model import BaseModel, Base
from sqlalchemy import Column, ForeignKey, String, Integer, DateTime
from datetime import datetime, timedelta


class BloodStock(BaseModel, Base):
    "Blood Stock table"
    __tablename__ = "blood_stock"

    blood_group_id = Column(String(60), ForeignKey('blood_groups.id'), nullable=False)
    blood_bank_id = Column(String(60), ForeignKey('blood_banks.id'), nullable=False)
    volume = Column(Integer, default=500, nullable=False)
    exp_date = Column(DateTime, default=lambda: datetime.utcnow() + timedelta(days=40))