import pandas as pd

from server.persistence.database import DATABASE

DATABASE.load('../../database')
#
# for_kmeans = DATABASE.users[[
#         'year_of_birth',
#         'sex',
#         'noise',
#         'chronic_condition',
#     ]]
#
# clusterer = KMeans(n_clusters=5)
# cluster = clusterer.fit_predict(for_kmeans)
#
# DATABASE.users['cluster'] = cluster
#
# DATABASE.save('../../database')

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
            'symptom': 'Eczema',
            'text': 'Try to eat more vegetables!',
            'score': 4,
        }
    }

    # current_user = DATABASE.users[DATABASE.users['id'] == post['user_id']]
    #
    # print(DATABASE.users['id'] == post['user_id'])
    #
    # current_cluster = current_user['cluster'].values[0]
    # similar_users = DATABASE.users[DATABASE.users['cluster'] == current_cluster]
    #
    # joined = pd.merge(similar_users, DATABASE.posts, left_on='id', right_on='user_id')
    # filtered = joined[joined['symptom'] == post['symptom']]
    #
    # DATABASE.links['post_id_symptom'] = DATABASE.links['post_id_symptom'] + 1
    # DATABASE.links['post_id_solution'] = DATABASE.links['post_id_solution'] + 1
    #
    # joined_links = pd.merge(filtered, DATABASE.links, left_on='id_y', right_on='post_id_symptom')
    #
    # max_score = joined_links['score'].max()
    # best_link = DATABASE.links[DATABASE.links['score'] == max_score]
    #
    # solution_id = best_link.to_dict('records')[0]['post_id_solution']
    # best_solution = DATABASE.posts[DATABASE.posts['id'] == solution_id].to_dict('records')[0]
    #
    # filtered_suggestions = DATABASE.suggestions[DATABASE.suggestions['symptom'] == post['symptom']]
    # max_score = filtered_suggestions['score'].max()
    # best_suggestion = DATABASE.suggestions[DATABASE.suggestions['score'] == max_score].to_dict('records')[0]
    #
    # return {
    #     'post': best_solution,
    #     'suggestion': best_suggestion,
    # }
