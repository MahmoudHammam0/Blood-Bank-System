#!/usr/bin/python3
"creates blueprint for api app views"
from flask import Blueprint

app_views = Blueprint("app_views", __name__, url_prefix="/api/v1")

from api.v1.views.donors import *
from api.v1.views.cities import *
from api.v1.views.blood_groups import *
from api.v1.views.blood_banks import *
from api.v1.views.donations import *
from api.v1.views.blood_stocks import *
from api.v1.views.hospitals import *
from api.v1.views.patients import *
from api.v1.views.requests import *