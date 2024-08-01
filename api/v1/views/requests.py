#!/usr/bin/python3
"Requests API views"
from api.v1.views import app_views
from models import db
from models.request import Request
from models.hospital import Hospital
from models.blood_stock import BloodStock
from models.blood_grp import BloodGroup
from flask import jsonify, abort, request


@app_views.route("/requests", methods=["POST"])
def create_request():
    "create a new request for the hospital"
    request_dict = request.get_json()
    if not request_dict:
        abort(400, "Not a Valid Json")

    attributes = ['blood_group_id', 'hospital_id',
                  'patient_status', 'request_date',
                  'quantity_required']
    for attr in attributes:
        if attr not in request_dict.keys():
            abort(400, f"Missing {attr.capitalize()}")

    request_dict['fulfilment_status'] = "not fulfilled"
    
    new_request = Request(**request_dict)
    db.new(new_request)
    db.save()

    return jsonify(new_request.to_dict()), 201


@app_views.route('/requests')
def get_all_requests():
    "returns a list of all requests in storage"
    requests = []
    for req in db.all(Request).values():
        blood_group = db.get_obj(BloodGroup, req.blood_group_id)
        hospital = db.get_obj(Hospital, req.hospital_id)
        req_dict = req.to_dict()
        req_dict['hospital_name'] = hospital.name
        req_dict['blood_group_name'] = blood_group.type
        requests.append(req_dict)
    return jsonify(requests)


@app_views.route('/requests/<request_id>')
def get_request_by_id(request_id):
    "returns a request with specific id"
    request = db.get_obj(Request, request_id)
    if request:
        return jsonify(request.to_dict())
    else:
        abort(404)


@app_views.route('/requests/hospital/<hospital_id>')
def get_requests_for_hospital(hospital_id):
    "return requests for a specific hospital"
    hospital = db.get_obj(Hospital, hospital_id)
    requests = []
    if hospital:
        for req in hospital.requests:
            requests.append(req.to_dict())
        return jsonify(requests)
    else:
        abort(404)


@app_views.route('/requests/fulfilment/<hospital_id>')
def check_request_fulfilment(hospital_id):
    "check if a hospital request can be fullfilled from the stock"
    hospital = db.get_obj(Hospital, hospital_id)
    requests = hospital.requests
    full_summary = db.check_hospital_requests(hospital_id)
    request_summary = full_summary["summary"]
    if not full_summary:
        return jsonify({"request_status": "requests can't be fulfilled"})
    stock_summary = db.check_blood_bank_stock()

    for key in list(request_summary.keys()):
        if key not in stock_summary or stock_summary[key]["total_volume"] < request_summary[key]:
            full_summary["quantity requested"] -= (request_summary[key] / 500)
            del request_summary[key]

    print(full_summary)

    if full_summary["quantity requested"] >= 10 and request_summary:
        for key, volume in request_summary.items():
            stock_list = stock_summary[key]["stocks"]
            while volume > 0 and stock_list:
                stock_id = stock_list.pop()
                stock = db.get_obj(BloodStock, stock_id)
                volume -= stock.volume
                db.delete(stock)
        for req in requests:
            blood_group = db.get_obj(BloodGroup, req.blood_group_id)
            if req.quantity_required * 500 <= request_summary.get(blood_group.type, 0):
                req.fulfilment_status = "fulfilled"
            req.save()
        db.save()
        return jsonify({"request_status": "requests fulfilled successfully"})
    else:
        return jsonify({"request_status": "requests can't be fulfilled"})