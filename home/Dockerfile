from python:3.7-slim

run pip install pipenv

WORKDIR /home

copy Pipfile Pipfile.lock ./
run pipenv install --system --deploy --ignore-pipfile --sequential

ENTRYPOINT ["hass", "--config", "/config"]
cmd ["--open-ui"]
