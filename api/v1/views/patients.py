#!/usr/bin/python3
"Patients API views"
from api.v1.views import app_views
from models import db
from models.patient import Patient
from models.hospital import Hospital
from models.blood_grp import BloodGroup
from flask import jsonify, abort


@app_views.route("/patients")
def get_all_patients():
    "return a list of all patients in storage"
    patients = []
    for patient in db.all(Patient).values():
        patients.append(patient.to_dict())
    return jsonify(patients)


@app_views.route("/patients/<patient_id>")
def get_patient_by_id(patient_id):
    "return patient with specific id"
    patient = db.get_obj(Patient, patient_id)
    blood_group = db.get_obj(BloodGroup, patient.blood_group_id)
    if patient:
        patient_dict = patient.to_dict()
        patient_dict['blood_group'] = blood_group.type
        return jsonify(patient_dict)
    else:
        abort(404)


@app_views.route("/patients/hospital/<hospital_id>")
def get_patients_for_hospital(hospital_id):
    "returns all patients for a specific hospital"
    patients = []
    hospital = db.get_obj(Hospital, hospital_id)
    if hospital:
        for patient in hospital.patients:
            patients.append(patient.to_dict())
        return jsonify(patients)
    else:
        abort(404)