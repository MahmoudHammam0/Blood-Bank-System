#!/usr/bin/python3
"API app module"
from flask import Flask, jsonify
from models import db
from flask_cors import CORS
from api.v1.views import app_views


app = Flask(__name__)
cors = CORS(app, resources={r"/api/v1/*": {"origins": "*"}})
app.register_blueprint(app_views)


@app.teardown_appcontext
def tear_down(e):
    "close the db session after each request"
    db.close()

@app.errorhandler(404)
def not_found(error):
    return jsonify({"Error": error.description}), 404


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001, threaded=True, debug=True)