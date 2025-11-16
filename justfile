# https://just.systems

setup:
    pre-commit install --install-hooks

lint:
    pre-commit run -a --hook-stage manual

serve:
    hugo server -D -w
