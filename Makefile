format:
	python -m black -S --line-length 79 ./
	isort ./

type:
	mypy --ignore-missing-imports ./

lint:
	flake8 ./

ci: format type lint 