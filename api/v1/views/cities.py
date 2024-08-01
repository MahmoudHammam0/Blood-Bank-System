#!/usr/bin/python3
"Cities API views"
from models import db
from flask import jsonify, abort
from models.city import City
from api.v1.views import app_views


@app_views.route("/cities")
def get_all_cities():
    "return all cities in storage"
    cities = []
    for city in db.all(City).values():
        cities.append(city.to_dict())
    return jsonify(cities)

@app_views.route("/cities/<city_id>")
def get_city_by_id(city_id):
    "return city by specific id"
    city = db.get_obj(City, city_id)
    if city:
        return jsonify(city.to_dict())
    else:
        abort(404)


@app_views.route("/cities/<city_id>/blood_banks")
def get_blood_banks_in_city(city_id):
    "return blood_banks within a city"
    blood_banks = []
    city = db.get_obj(City, city_id)
    banks = city.blood_banks
    if banks:
        for bank in banks:
            blood_banks.append(bank.to_dict())
        return jsonify(blood_banks)
    else:
        abort(404)