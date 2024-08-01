#!/usr/bin/python3
"Database storage class"
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session
from models.base_model import Base, BaseModel
from models.donor import Donor
from models.city import City
from models.blood_grp import BloodGroup
from models.blood_donation import BloodDonation
from models.blood_stock import BloodStock
from models.blood_bank import BloodBank
from models.hospital import Hospital
from models.patient import Patient
from models.request import Request


class DBStorage:
    "Database class engine using sqlalchemy"
    __engine = None
    __session = None
    classes = {
        'BaseModel': BaseModel,
        'Donor': Donor,
        'City': City,
        'BloodGroup': BloodGroup,
        'BloodStock': BloodStock,
        'BloodBank': BloodBank,
        'Hospital': Hospital,
        'Patient': Patient,
        'Request': Request,
        'BloodDonation': BloodDonation,
    }

    def __init__(self):
        "constructor to create the db engine"
        user = "cbb_user"
        password = "cbb_pwd"
        host = "localhost"
        db = "cbb_db"

        self.__engine = create_engine('mysql+mysqldb://{}:{}@{}/{}'\
                                      .format(user, password, host, db))
        
    def all(self, cls):
        "query the database for all instances with specific class"
        objects_dict = {}
        objects = self.__session.query(cls).all()
        for obj in objects:
            key = obj.id
            objects_dict[key] = obj
        return objects_dict
    
    def new(self, object):
        "add the object to the current db session"
        self.__session.add(object)

    def save(self):
        "commit the current changes in the db session"
        self.__session.commit()

    def delete(self, object):
        "delete an object from the db session"
        self.__session.delete(object)

    def db_reload(self):
        "create the db session and create all the tables"
        Base.metadata.create_all(self.__engine)
        Session = sessionmaker(bind=self.__engine, expire_on_commit=False)
        self.__session = scoped_session(Session)

    def close(self):
        "close the db session after each request"
        self.__session.close()

    def get_obj(self, cls, id):
        "retrieve one object of a class based on its id"
        if cls in self.classes.values():
            object_dict = self.all(cls)
            if id in object_dict:
                return object_dict[id]
        return None
    
    def check_email(self, email_to_check):
        "check email during registeration"
        donor = self.__session.query(Donor).filter_by(email=email_to_check).first()
        if donor:
            return donor
        return False
    
    def check_national_id(self, national_id_to_check):
        "check national_id during registeration"
        donor = self.__session.query(Donor).filter_by(national_id=national_id_to_check).first()
        if donor:
            return donor
        return False
    
    def check_login_credentials(self, email_to_check, id_to_check):
        "check the login email"
        donor = self.__session.query(Donor).filter_by(email=email_to_check).first()
        if donor:
            if donor.national_id == id_to_check:
                return donor
        return False
    
    def check_blood_bank_stock(self):
        "returns a summary dictionary of blood stock in a blood bank"
        stocks = list(self.all(BloodStock).values())
        if not stocks:
            return {}
        summary = {}
        for stock in stocks:
            blood_group = self.get_obj(BloodGroup, stock.blood_group_id)
            name = blood_group.type
            if name not in summary:
                summary[name] = {
                    "total_volume": 0,
                    "stocks": []
                    }
            summary[name]["total_volume"] += stock.volume
            summary[name]["stocks"].append(stock.id)
        return summary
    
    def check_hospital_requests(self, hospital_id):
        "check the hospital requests and returns a summary of the request"
        hospital = self.get_obj(Hospital, hospital_id)
        requests = hospital.requests
        quantity = 0
        for req in requests:
            quantity += req.quantity_required
        if quantity < 10:
            return {}
        summary = {}
        for req in requests:
            blood_group = self.get_obj(BloodGroup, req.blood_group_id)
            name = blood_group.type
            if name not in summary:
                summary[name] = 0
            summary[name] += (req.quantity_required * 500)
        full_summary = {"quantity requested": quantity, "summary": summary}
        return full_summary
    
    def last_accepted_donation(self, donor):
        "finds the date of the last accepted donation for a donor"
        last = self.__session.query(BloodDonation)\
            .filter_by(donor_id=donor.id, result="accepted")\
            .order_by(BloodDonation.donation_date.desc())\
            .first()
        if last:
            return last
        return False