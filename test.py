#!/usr/bin/python3
from models import db
from models.donor import Donor
from models.city import City
from models.blood_grp import BloodGroup
from models.blood_donation import BloodDonation
from models.blood_stock import BloodStock
from models.hospital import Hospital
from models.blood_bank import BloodBank
from models.patient import Patient
from models.request import Request
from datetime import datetime

# egypt_governorates = [
#     'Giza',
#     'Dakahlia',
#     'Sharkia',
#     'Qalyubia',
#     'Beheira',
#     'Kafr el-Sheikh',
#     'Monufia',
#     'Gharbia',
#     'Beni Suef',
#     'Fayoum',
#     'Minya',
#     'Assiut',
#     'Sohag',
#     'Qena',
#     'Luxor',
#     'Aswan',
#     'Red Sea',
#     'New Valley',
#     'North Sinai',
#     'South Sinai'
# ]

# for city in egypt_governorates:
#     new_city = City(name=city)
#     new_city.save()

#     new_blood_bank = BloodBank(name=f"{city} blood bank", password=f"{city} 123", city_id=new_city.id)
#     new_blood_bank.save()

#     new_hospital = Hospital(name=f"{city} central hospital", password=f"{city} 123", city_id=new_city.id)
#     new_hospital.save()

hospitals = list(db.all(Hospital).values())
blood_groups = list(db.all(BloodGroup).values())

patients = ["Ahmed", "Mahmoud", "Said", "Khaled",
          "Ibrahem", "Youssef", "Nour", "Tamer",
            ]

status = ["Normal", "Urgent", "Immediate", "Normal", 
          "Urgent", "Immediate", "Normal", "Urgent", 
            ]

for i in range(len(hospitals)):

    for x in range(len(patients)):

        patient = Patient(
            name=patients[x],
            hospital_id=hospitals[i].id,
            blood_group_id=blood_groups[x].id,
            status=status[x],
        )
        patient.save()


print("DONE")