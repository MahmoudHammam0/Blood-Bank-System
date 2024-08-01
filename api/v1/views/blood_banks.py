#!/usr/bin/python3
"Blood banks API views"
from api.v1.views import app_views
from models import db
from models.blood_bank import BloodBank
from flask import jsonify, abort


@app_views.route("/blood_banks")
def get_all_blood_banks():
    "return all blood banks in storage"
    blood_banks = []
    for bank in db.all(BloodBank).values():
        blood_banks.append(bank.to_dict())
    return jsonify(blood_banks)


@app_views.route("/blood_banks/<blood_bank_id>")
def get_blood_bank_by_id(blood_bank_id):
    "return blood bank by specific id"
    bank = db.get_obj(BloodBank, blood_bank_id)
    if bank:
        return jsonify(bank.to_dict())
    else:
        abort(404)