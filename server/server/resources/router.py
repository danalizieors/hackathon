from server.resources.Advice import Advice
from server.resources.Posts import Posts, Post
from server.resources.User import Users, User


def route(api):
    api.add_resource(Advice, '/advice')
    api.add_resource(Posts, '/posts')
    api.add_resource(Post, '/posts/<index>')
    api.add_resource(Users, '/users')
    api.add_resource(User, '/users/<index>')
