.DEFAULT_GOAL := all
isort = isort balsam tests
black = black --target-version py37 balsam tests

.PHONY: format
format:
	$(isort)
	$(black)

.PHONY: lint
lint:
	flake8 balsam/ tests/
	$(isort) --check-only --df
	$(black) --check --diff

.PHONY: mypy
mypy:
	mypy --config-file setup.cfg --package balsam

.PHONY: test-api
test-api:
	pytest tests/server --cov=balsam --cov-config setup.cfg
	pytest tests/api --cov=balsam --cov-append --cov-config setup.cfg

.PHONY: testcov
testcov: test-api
	@echo "building coverage html"
	@coverage html

.PHONY: all
all: lint mypy testcov
