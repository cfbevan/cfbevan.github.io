# https://just.systems

lint:
    vale sync
    vale --config=.vale.ini --minAlertLevel=error ./content/**/*.md

serve:
    hugo server -D -w
