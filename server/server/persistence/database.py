import pandas as pd


class Database:
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


def columns(*names):
    return pd.DataFrame(columns=names)


DATABASE = Database()
