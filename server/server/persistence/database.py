import pandas as pd

from server.persistence.PanDatabase import PanDatabase


class Database(PanDatabase):
    def __init__(self):
        self.users = columns(

            # identification
            'id',

            # attributes
            'sex',
            'year_of_birth',
            'height',
            'weight',
            'fitness',
            'pulse',
            'sleep',
            'noise',
            'home_location',

            # preferences
            'in_temperature',
            'in_humidity',
        )

        self.posts = columns(

            # identification
            'id',
            'user_id',

            # user defined
            'symptom_id',

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

            # wearable
            'fitness',
            'pulse',
            'sleep',
        )

        self.links = columns(

            # identification
            'post_id_symptom',
            'post_id_solution',
        )

        self.symptoms = columns(

            # identification
            'id',
            'user_id',

            # attributes
            'severity',
            'suggestion_id',
        )

        self.suggestions = columns(

            # identification
            'id',
            'user_id',

            # attributes
            'text'
            'score',
        )


def columns(*names):
    return pd.DataFrame(columns=names)


DATABASE = Database()
