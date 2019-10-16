from flask import request, jsonify
from flask_restful import Resource


data = {
    'temperature': 24.5,
    'humidity': 48,
    'illuminance': 358,
    'dust': 65,
    'noise': 45,
}


class Sensor(Resource):
    def get(self):
        return jsonify(data)

    def post(self):
        global data
        data = request.json
