#!/usr/bin/python3
"blood groups API views"
from api.v1.views import app_views
from models import db
from models.blood_grp import BloodGroup
from flask import abort, jsonify


@app_views.route("/blood_groups")
def get_all_blood_groups():
    "return a list of all blood groups"
    groups = []
    for group in db.all(BloodGroup).values():
        groups.append(group.to_dict())
    return jsonify(groups)


@app_views.route('/blood_groups/<blood_group_id>')
def blood_group_by_id(blood_group_id):
    "return blood group with specific id"
    blood_group = db.get_obj(BloodGroup, blood_group_id)
    if blood_group:
        return jsonify(blood_group.to_dict())
    else:
        abort(404)