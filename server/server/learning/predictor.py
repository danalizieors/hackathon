def predict(post):
    return {
        'post': {
            # outside
            'temperature': 17,
            'pressure': 1032,
            'humidity': 70,
            'wind': 4,

            # inside
            'in_temperature': 21,
            'in_humidity': 43,
            'in_dust': 32,
            'in_noise': 32,

            'fitness': 87,
            'pulse': 65,
            'sleep': 89,
        },
        'suggestion': {
            'symptom': 'Flu',
            'text': 'Get Advil!',
            'score': 4,
        }
    }
