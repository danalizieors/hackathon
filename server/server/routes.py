from database import DATABASE


def route(app):
    @app.route('/method1')
    def method1():
        DATABASE["data"] += 1
        return str(DATABASE["data"])

    @app.route('/method2')
    def method2():
        DATABASE["data"] -= 1
        return str(DATABASE["data"])
