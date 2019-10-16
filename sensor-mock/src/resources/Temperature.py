from flask import request, jsonify
from flask_restful import Resource


class Temperature(Resource):
    def get(self):
        data = {
            "date": "10-16-2019",
            "milliseconds_since_epoch": 1571215262848,
            "time": "08:41:02 AM"
        }
        return jsonify(data)
