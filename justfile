# https://just.systems

setup:
    pre-commit install

lint:
    pre-commit run -a --hook-stage manual

serve:
    hugo server -D -w
