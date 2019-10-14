from flask import request
from flask_restful import Resource

import server.persistence.utils as u


class Advice(Resource):
    def post(self):
        data = request.json
        id = u.addPost(data)
        post = u.getPostBy(id)
        # call predictor below
        prediction = post
        return prediction
