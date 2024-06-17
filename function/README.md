# FastAPI on Azure function

## Local usage
Create virtual environment and install dependencies.
```sh
python -m venv .venv
source .venv/bin/activate
pip install -r requirements-dev.txt
```

Run the the FastAPI app.
```sh
fastapi dev app/main.py
```

Run unit tests.
```sh
pytest
```
