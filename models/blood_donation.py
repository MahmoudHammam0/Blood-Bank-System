#!/usr/bin/python3
"Blood donation table module"
from models.base_model import BaseModel, Base
from sqlalchemy import DateTime, Column, String, ForeignKey, Boolean, Integer
from datetime import datetime


class BloodDonation(BaseModel, Base):
    "Blood donation table"
    __tablename__ = "blood_donations"

    donor_id = Column(String(60), ForeignKey("donors.id"), nullable=False)
    blood_group_id = Column(String(60), ForeignKey("blood_groups.id"), nullable=False)
    blood_bank_id = Column(String(60), ForeignKey("blood_banks.id"), nullable=False)
    virus_test_result = Column(Boolean, nullable=False)
    donation_date = Column(DateTime, nullable=False)
    result = Column(String(60), nullable=False)
    reason_for_rejection = Column(String(60), nullable=True)