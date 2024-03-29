from server.persistence.database import DATABASE


def getPosts():
    posts = DATABASE.posts
    return posts.to_dict('records')


def getPostsBy(user_id):
    posts = DATABASE.posts
    filtered = posts[posts['user_id'] == user_id]
    return filtered.to_dict('records')


def getPostBy(id):
    posts = DATABASE.posts
    data = posts.to_dict('records')
    return data[int(id)]


def addPost(data):
    DATABASE.add('posts', data)
    return len(DATABASE.posts) - 1
