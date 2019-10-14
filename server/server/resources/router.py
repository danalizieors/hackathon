from server.resources.Advice import Advice
from server.resources.Posts import Posts, Post


def route(api):
    api.add_resource(Advice, '/advice')
    api.add_resource(Posts, '/posts')
    api.add_resource(Post, '/posts/<index>')
