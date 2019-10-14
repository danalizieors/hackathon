from flask import Flask

app = Flask(__name__)

cache = {
    "data": 0
}

@app.route('/method1')
def method1():
    cache["data"] += 1
    return str(cache["data"])

@app.route('/method2')
def method2():
    cache["data"] -= 1
    return str(cache["data"])

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)
