import pandas as pd

from server.persistence.PanDatabase import PanDatabase


class Database(PanDatabase):
    def __init__(self):
        self.posts = columns(
            'id',
            'user_id',
            'symptom',
            'time',
            'location',
            'temperature',
            'humidity',
            'precipitation',
            'wind',
        )
        self.example = columns(
            'first',
            'second',
        )


def columns(*names):
    return pd.DataFrame(columns=names)


DATABASE = Database()
DATABASE.load('../../database/mock')
print(DATABASE)
