#!/usr/bin/python3
"Hospitals API views"
from api.v1.views import app_views
from models import db
from models.hospital import Hospital
from flask import jsonify, abort


@app_views.route("/hospitals")
def get_all_hospitals():
    "return a list of all hospitals in storage"
    hospitals = []
    for hospital in db.all(Hospital).values():
        hospitals.append(hospital.to_dict())
    return jsonify(hospitals)


@app_views.route("/hospitals/<hospital_id>")
def get_hospital_by_id(hospital_id):
    "return hospital with specific id"
    hospital = db.get_obj(Hospital, hospital_id)
    if hospital:
        return jsonify(hospital.to_dict())
    else:
        abort(404)