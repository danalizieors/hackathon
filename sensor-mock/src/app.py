from flask import Flask
from flask_restful import Api

from src.resources.router import route

app = Flask(__name__)
api = Api(app)

route(api)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=9000)
