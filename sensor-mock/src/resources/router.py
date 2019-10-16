from src.resources.Sensor import Sensor


def route(api):
    api.add_resource(Sensor, '/sensor')
