from flask import request
from flask_restful import Resource

import server.persistence.utils as u
from server.learning.predictor import predict


class Advice(Resource):
    def post(self):
        data = request.json
        id = u.addPost(data)
        post = u.getPostBy(id)
        prediction = predict(post)
        return prediction
