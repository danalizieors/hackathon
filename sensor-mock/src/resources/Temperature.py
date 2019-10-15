from flask import request, jsonify
from flask_restful import Resource


class Temperature(Resource):
    def get(self):
        return 24
