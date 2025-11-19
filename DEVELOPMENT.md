# Development Guide

This document contains instructions for developing and testing the Stytch Management Python SDK.

## Prerequisites

- Python 3.8 or higher
- pip

## Setup

1. Clone the repository:

```bash
git clone https://github.com/stytchauth/stytch-management-python.git
cd stytch-management-python
```

2. Install dependencies:

```bash
pip install -r requirements_dev.txt
```

## Project Structure

```
stytch-management-python/
├── stytch_management/          # Main package directory
│   ├── __init__.py             # Package exports
│   ├── client.py               # Main ManagementClient class (generated)
│   ├── http_client.py          # HTTP client (hand-written)
│   ├── errors.py               # Error classes (hand-written)
│   ├── version.py              # Version info (hand-written)
│   ├── models/                 # Pydantic models (generated)
│   ├── projects.py             # Projects resource client (generated)
│   ├── secrets.py              # Secrets resource client (generated)
│   └── ...                     # Other resource clients (generated)
├── test/                       # Test directory
├── setup.py                    # Package configuration
├── requirements.txt            # Runtime dependencies
├── requirements_dev.txt        # Development dependencies
├── README.md                   # User documentation
└── DEVELOPMENT.md              # This file
```

## Code Generation

The SDK is partially generated from protobuf definitions in the [stytch/api](https://github.com/stytchauth/api) repository using [sdk-codegen](https://github.com/stytchauth/sdk-codegen).

### Generated Files

The following files are automatically generated:
- `stytch_management/client.py` - Main client class
- `stytch_management/projects.py` - Resource clients
- `stytch_management/models/*.py` - Pydantic models for requests/responses

### Hand-Written Files

The following files are hand-written and should be modified directly:
- `stytch_management/__init__.py` - Package initialization
- `stytch_management/http_client.py` - HTTP client implementation
- `stytch_management/errors.py` - Error classes
- `stytch_management/version.py` - Version information

### Regenerating Code

To regenerate the SDK after API changes:

```bash
cd /path/to/sdk-codegen
make gen-pwa-python
```

This will:
1. Parse the protobuf definitions
2. Apply transformations
3. Generate Python code from templates
4. Format the code with autoflake, isort, and black

## Testing

### Running Tests

Run all tests:

```bash
python -m unittest discover test
```

Run with verbose output:

```bash
python -m unittest discover test -v
```

Run specific test file:

```bash
python -m unittest test.test_client
```

Run specific test class:

```bash
python -m unittest test.test_client.TestClient
```

Run specific test method:

```bash
python -m unittest test.test_client.TestClient.test_create_client_with_valid_config
```

Run with coverage:

```bash
coverage run -m unittest discover test
coverage report
coverage html  # Generate HTML coverage report
```

### Writing Tests

Tests should be placed in the `test/` directory and use Python's built-in `unittest` framework.

Example test:

```python
import unittest
from stytch_management import Client
from stytch_management.errors import ClientError


class TestClient(unittest.TestCase):
    """Test Client initialization."""

    def test_client_initialization(self):
        """Test that a client can be created with valid credentials."""
        client = Client(
            workspace_key_id="workspace-test-123",
            workspace_key_secret="secret-test-456"
        )
        self.assertIsNotNone(client)

    def test_missing_credentials(self):
        """Test that ValueError is raised when credentials are missing."""
        with self.assertRaises(ValueError):
            Client(
                workspace_key_id="",
                workspace_key_secret="secret"
            )


if __name__ == "__main__":
    unittest.main()
```

### Integration Tests

Integration tests require real API credentials. Set these environment variables:

```bash
export STYTCH_WORKSPACE_KEY_ID="workspace-test-..."
export STYTCH_WORKSPACE_KEY_SECRET="secret-test-..."
```

Integration tests are skipped by default if credentials are not set.

## Code Quality

### Formatting

Format code with black:

```bash
black stytch_management/
```

Sort imports with isort:

```bash
isort --profile black stytch_management/
```

Remove unused imports with autoflake:

```bash
autoflake --in-place --remove-all-unused-imports --recursive stytch_management/
```

### Type Checking

Run mypy for type checking:

```bash
mypy stytch_management/
```

## Building and Publishing

### Building the Package

```bash
python setup.py sdist bdist_wheel
```

### Publishing to PyPI

```bash
pip install twine
twine upload dist/*
```

## Contributing

1. Create a feature branch
2. Make your changes
3. Add tests
4. Run formatters and linters
5. Submit a pull request

## Support

For questions or issues, contact [support@stytch.com](mailto:support@stytch.com).
