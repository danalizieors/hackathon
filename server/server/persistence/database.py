import pandas as pd

from server.persistence.PanDatabase import PanDatabase


class Database(PanDatabase):
    def __init__(self):
        self.users = columns(

            # identification
            'id',
            'user_token',

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
            'symptom',
            'severity',

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

        self.suggestions = columns(

            # identification
            'id',

            # attributes
            'symptom',
            'text',
            'score',
        )

        self.targeted_suggestions = columns(

            # identification
            'id',

            # attributes
            'symptom',
            'metric',
            'relation',
            'score'
        )


def columns(*names):
    return pd.DataFrame(columns=names)


DATABASE = Database()
