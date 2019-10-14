from python:3.7-alpine

run pip install pipenv

WORKDIR /home

copy Pipfile Pipfile.lock ./
run pipenv install --system --deploy --ignore-pipfile --sequential

ENTRYPOINT ["python"]
cmd ["server/app.py"]

copy server server
