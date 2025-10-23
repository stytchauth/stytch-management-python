.PHONY: test
test:
	python3 -m unittest discover -s test -p "test_*.py" -v

.PHONY: test-verbose
test-verbose:
	python3 -m unittest discover -s test -p "test_*.py" -v

.PHONY: install
install:
	pip install -e .
	pip install -r requirements_dev.txt

.PHONY: clean
clean:
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	rm -rf .pytest_cache
	rm -rf stytch_management_python.egg-info
	rm -rf dist build
