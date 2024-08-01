#!/usr/bin/python3
"Donors API views"
from api.v1.views import app_views
from models import db
from models.donor import Donor
from models.city import City
from models.blood_grp import BloodGroup
from flask import jsonify, abort, request


@app_views.route('/donors')
def get_all_donors():
    "returns a list of all donors in the db storage"
    donors = []
    for donor in db.all(Donor).values():
        donors.append(donor.to_dict())
    return jsonify(donors)


@app_views.route('/donors/<donor_id>')
def get_donor_by_id(donor_id):
    "returns a donor with specific id"
    donor = db.get_obj(Donor, donor_id)
    city = db.get_obj(City, donor.city_id)
    blood_group = db.get_obj(BloodGroup, donor.blood_group_id)
    donor_dict = donor.to_dict()
    donor_dict['city'] = city.name
    donor_dict['blood_group'] = blood_group.type
    if donor:
        donor_dict = donor.to_dict()
        donor_dict['city'] = city.name
        donor_dict['blood_group'] = blood_group.type
        return jsonify(donor_dict)
    else:
        abort(404)

@app_views.route('/donors/<donor_id>', methods=["DELETE"])
def delete_donor(donor_id):
    "delete the donor with the specific id"
    donor = db.get_obj(Donor, donor_id)
    if donor:
        db.delete(donor)
        db.save()
        return jsonify({}), 200
    else:
        abort(404)


@app_views.route('/donors', methods=["POST"])
def create_donor():
    "create a donor for a specific blood bank"
    donor_dict = request.get_json()
    if not donor_dict:
        abort(400, "Not a valid Json")

    attributes = ['name', 'national_id',
                  'email', 'city_id', 'blood_group_id']
    
    for attr in attributes:
        if attr not in donor_dict.keys():
            abort(400, f"Missing {attr.capitalize()}")

    message = ''
    
    if db.check_email(donor_dict['email']):
        message += "Email already exists"
    
    if db.check_national_id(donor_dict['national_id']):
        if len(message) != 0:
            message += ' and '
        message += "National ID already registered"

    if message:
        abort(404, message)

    new_donor = Donor(**donor_dict)
    db.new(new_donor)
    db.save()

    return jsonify(new_donor.to_dict()), 201