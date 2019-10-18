import json

import pandas as pd

TABLE_TEMPLATE = '''========================================
        {}
========================================
{}
----------------------------------------

'''


class PanDatabase:
    def load(self, path):
        for key, value in self.__dict__.items():
            filename = '{}/{}.json'.format(path, key)
            data_frame = read_json(filename)
            self.add(key, data_frame)

    def save(self, path):
        for key, value in self.__dict__.items():
            filename = '{}/{}.json'.format(path, key)
            write_json(value, filename)

    def __str__(self):
        table_strings = [TABLE_TEMPLATE.format(key, value)
                         for key, value in self.__dict__.items()]
        return ''.join(table_strings)

    def add(self, key, values):
        data_frame = getattr(self, key)
        new_data_frame = data_frame.append(values, ignore_index=True, sort=False)
        setattr(self, key, new_data_frame)


def write_json(data_frame, filename):
    data = data_frame.to_dict(orient='records')
    with open(filename, 'w', encoding='utf-8') as file:
        json.dump(data, file, ensure_ascii=False, indent=2)


def read_json(filename):
    try:
        return pd.read_json(filename, orient='records')
    except ValueError:
        return None
