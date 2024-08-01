#!/usr/bin/python3
"Donations API views"
from api.v1.views import app_views
from models import db
from models.blood_donation import BloodDonation
from models.donor import Donor
from models.blood_grp import BloodGroup
from models.blood_bank import BloodBank
from flask import jsonify, request, abort
from datetime import datetime
from email_util import send_rejection_email


@app_views.route("/donations", methods=["POST"])
def create_donation():
    "create a new donation and return it"
    donation_dict = request.get_json()
    if not donation_dict:
        abort(400, "Not a valid Json")

    attributes = ['donor_id', 'blood_group_id',
                  'blood_bank_id', 'virus_test_result']
    
    for attr in attributes:
        if attr not in donation_dict.keys():
            abort(400, f"Missing {attr.capitalize()}")

    donation_date = datetime.strptime(
        donation_dict['donation_date'], '%Y-%m-%d')
    donation_dict['donation_date'] = donation_date

    donor_id = donation_dict['donor_id']
    donor = db.get_obj(Donor, donor_id)
    donation_dict['result'] = "accepted"
    donation_dict['reason_for_rejection'] = []

    if donation_dict['virus_test_result'] == True:
        donation_dict['result'] = "rejected"
        donation_dict['reason_for_rejection'].append("Virus blood test positive")

    if len(donor.donations) > 0:
        last_accepted_donation = db.last_accepted_donation(donor)
        if last_accepted_donation:
            last_donation_date = (donation_date - last_accepted_donation.donation_date).days
            if last_donation_date < 90:
                donation_dict['result'] = "rejected"
                donation_dict['reason_for_rejection'].append("Last donation less than 3 months")

    if donation_dict['reason_for_rejection']:
        donation_dict['reason_for_rejection'] = ", ".\
            join(donation_dict['reason_for_rejection']) + "."
    else:
        donation_dict['reason_for_rejection'] = ""
        

    new_donation = BloodDonation(**donation_dict)
    db.new(new_donation)
    db.save()

    return jsonify(new_donation.to_dict()), 201


@app_views.route('/donations')
def get_all_donations():
    "returns a list of all donations in the db storage"
    donations = []
    for donation in db.all(BloodDonation).values():
        donations.append(donation.to_dict())
    return jsonify(donations)


@app_views.route('/donations/<donation_id>')
def get_donation_by_id(donation_id):
    "returns a donation with specific id"
    donation = db.get_obj(BloodDonation, donation_id)
    blood_group = db.get_obj(BloodGroup, donation.blood_group_id)
    blood_bank = db.get_obj(BloodBank, donation.blood_bank_id)
    if donation:
        donation_dict = donation.to_dict()
        donation_dict['blood_group'] = blood_group.type
        donation_dict['blood_bank'] = blood_bank.name
        return jsonify(donation_dict)
    else:
        abort(404)


@app_views.route('/donations/<donation_id>', methods=["DELETE"])
def delete_donation(donation_id):
    "delete the donor with the specific id"
    donation = db.get_obj(BloodDonation, donation_id)
    if donation:
        db.delete(donation)
        db.save()
        return jsonify({}), 200
    else:
        abort(404)


@app_views.route('/donations/rejection/<donation_id>')
def send_email(donation_id):
    "send donationa rejection notice"
    donation = db.get_obj(BloodDonation, donation_id)
    donor = db.get_obj(Donor, donation.donor_id)
    if donor:
        if donation.result == "rejected":
            subject = "Blood Donation Rejection Notice"
            message = f"""
            Dear {donor.name},
            Your recent donation was rejected due to the following reasons:
            {donation.reason_for_rejection}
            Thank you for your understanding.
            """
        send_rejection_email(donor.email, subject, message)
        return jsonify({"Status": "Rejection email sent successfully"})
    else:
        abort(404)