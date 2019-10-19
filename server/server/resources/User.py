from flask import jsonify, request
from flask_restful import Resource

from server.persistence.database import DATABASE


class Users(Resource):
    def get(self):
        users = DATABASE.users
        records = users.to_dict('records')
        return jsonify(records)

    def post(self):
        data = request.json
        DATABASE.add('users', data)
        return len(DATABASE.users) - 1


class User(Resource):
    def get(self, index):
        users = DATABASE.users
        data = users.to_dict('records')
        return data[int(index)]
