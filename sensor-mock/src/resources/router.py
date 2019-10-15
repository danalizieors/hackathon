from src.resources.Temperature import Temperature


def route(api):
    api.add_resource(Temperature, '/temperature')
