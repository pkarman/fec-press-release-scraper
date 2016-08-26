all: check

check: test

test:
	PYTHONPATH='.' prove -r tests

run:
	./fec-press-release-scraper

.PHONY: all check test run
