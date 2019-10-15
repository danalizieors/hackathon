from python:3.7-slim

run pip install pipenv

WORKDIR /home
env PYTHONPATH=${PYTHONPATH}:${PWD}

copy Pipfile Pipfile.lock ./
run pipenv install --system --deploy --ignore-pipfile --sequential

ENTRYPOINT ["python"]
cmd ["server/app.py"]

copy server server
