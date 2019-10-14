from flask import Flask
from routes import route

app = Flask(__name__)
route(app)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
