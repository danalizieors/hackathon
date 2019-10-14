install:
	export PIPENV_VENV_IN_PROJECT="enabled" && \
	pipenv install

format:
	pipenv run autopep8 --in-place --recursive server

run:
	docker-compose up --build
