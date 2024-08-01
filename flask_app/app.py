#!/usr/bin/python3
"Flask app"
from flask import Flask, jsonify, render_template, request, abort, redirect, url_for
from models import db
from flask_login import LoginManager, login_user, logout_user, current_user
from models.donor import Donor


app = Flask(__name__)
app.config['SECRET_KEY'] = '420d61563971313761f2e61f'
login_manager = LoginManager(app)


@app.route('/', strict_slashes=False)
def home():
    "home page"
    return render_template("home.html")


@app.route("/register", methods=["GET", "POST"])
def register_donor():
    "donor registeration page"
    return render_template("donor.html")

@app.route("/login", methods=["GET", "POST"])
def login():
    "login donor"
    if request.method == "POST":
        donor_dict = request.get_json()
        if not donor_dict:
            abort(400, "Not a valid Json")

        attributes = ['national_id', 'email']
    
        for attr in attributes:
            if attr not in donor_dict.keys():
                abort(400, f"Missing {attr.capitalize()}")

        donor = db.check_login_credentials(donor_dict['email'], donor_dict['national_id'])
        if donor:
            login_user(donor)
            return jsonify(donor.to_dict())
        else:
            abort(404, "Email and National ID doesn't match")
    else:       
        return render_template("login.html")


@app.route("/<donor_id>/donation", methods=["GET", "POST"])
def add_donation(donor_id):
    "donation registeration page"
    return render_template("donation.html", donor_id=donor_id)


@app.route("/accepted/<donation_id>", methods=["GET", "POST"])
def accepted(donation_id):
    "donation finalization page"
    return render_template("accepted.html", donor_id=current_user.id)

@app.route("/success/<stock_id>")
def success(stock_id):
    "donation success page"
    last_donation = db.last_accepted_donation(current_user)
    formatted_date = last_donation.donation_date.strftime('%d %b %Y')
    return render_template("success.html", date=formatted_date, donor_id=current_user.id)


@app.route("/rejected/<donation_id>")
def rejected_donation(donation_id):
    "donation rejection page"
    return render_template("rejected.html", donor_id=current_user.id)


@app.route("/request")
def hospital_request():
    "hospital request page"
    return render_template("request.html")


@app.route("/stock")
def stock():
    "blood stock page"
    return render_template("stock.html")


@app.route("/request_history")
def req_history():
    "requests archive page"
    return render_template("req_history.html")


@app.route('/logout')
def logout():
    "logout current donor"
    logout_user()
    return redirect(url_for("home"))

@login_manager.user_loader
def load_donor(donor_id):
    donor = db.get_obj(Donor, donor_id)
    if donor:
        return donor
    return None


@app.errorhandler(404)
def not_found(error):
    "Page Not Found"
    return jsonify({"Error": error.description}), 404


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, threaded=True, debug=True)