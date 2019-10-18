import pandas as pd

from server.persistence.PanDatabase import PanDatabase


class Database(PanDatabase):
    def __init__(self):
        self.posts = columns(

            # identification
            'id',  # automatically set
            'user_id',  # sent in request

            # user defined
            'type',  # acute | chronic
            'symptom',  # selected or defined by user
            'affected',  # is the user currently affected
            'notice',  # user's observations

            # phone
            'time',
            'location',

            # outside
            'temperature',
            'pressure',
            'humidity',
            'wind',

            # inside
            'in_temperature',
            'in_humidity',
            'in_dust',
            'in_noise',
        )


def columns(*names):
    return pd.DataFrame(columns=names)


DATABASE = Database()
DATABASE.load('../../database/mock')
print(DATABASE)
