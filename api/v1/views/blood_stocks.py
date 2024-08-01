#!/usr/bin/python3
"Blood Stock API views"
from api.v1.views import app_views
from models import db
from models.blood_stock import BloodStock
from models.blood_grp import BloodGroup
from models.blood_bank import BloodBank
from flask import jsonify, abort, request


@app_views.route("/blood_stocks")
def get_all_stocks():
    "return a list of all stocks in storage"
    stocks = []
    for stock in db.all(BloodStock).values():
        stocks.append(stock.to_dict())
    return jsonify(stocks)


@app_views.route("/blood_stocks/<stock_id>")
def get_stock_by_id(stock_id):
    "return blood stock with specific id"
    stock = db.get_obj(BloodStock, stock_id)
    blood_group = db.get_obj(BloodGroup, stock.blood_group_id)
    blood_bank = db.get_obj(BloodBank, stock.blood_bank_id)
    if stock:
        stock_dict = stock.to_dict()
        stock_dict['blood_group'] = blood_group.type
        stock_dict['blood_bank'] = blood_bank.name
        return jsonify(stock_dict)
    else:
        abort(404)


@app_views.route("/blood_stocks/blood_group/<blood_group_id>")
def get_stocks_for_blood_group(blood_group_id):
    "returns all stocks for a specific blood group"
    stocks = []
    blood_group = db.get_obj(BloodGroup, blood_group_id)
    if blood_group:
        for stock in blood_group.stocks:
            stocks.append(stock.to_dict())
        return jsonify(stocks)
    else:
        abort(404)


@app_views.route("/blood_stocks", methods=["POST"])
def create_blood_stock():
    "add new blood to the stock"
    stock_dict = request.get_json()
    if not stock_dict:
        abort(400, "Not Valid Json")

    attributes = ['blood_bank_id', 'blood_group_id',
                  'volume', 'exp_date']
    for attr in attributes:
        if attr not in stock_dict.keys():
            abort(404, f"Missing {attr.capitalize()}")

    new_stock = BloodStock(**stock_dict)
    db.new(new_stock)
    db.save()

    return jsonify(new_stock.to_dict()), 201


@app_views.route("/blood_stocks/summary")
def blood_stock_summary():
    "return a summary of blood stock"
    summary = db.check_blood_bank_stock()
    if summary:
        return jsonify(summary)
    else:
        abort(404)