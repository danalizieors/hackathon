from flask import request, jsonify
from flask_restful import Resource

import server.persistence.utils as u


class Posts(Resource):
    def get(self):
        user_id = request.args.get('user_id')
        data = u.getPosts() if user_id is None else u.getPostsBy(user_id)
        return jsonify(data)

    def post(self):
        data = request.json
        return u.addPost(data)


class Post(Resource):
    def get(self, index):
        data = u.getPostBy(int(index))
        return jsonify(data)
