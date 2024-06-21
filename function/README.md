# FastAPI as Azure function

## Local usage
Create virtual environment and install dependencies.
```sh
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Run the the FastAPI app.
```sh
fastapi dev app/main.py
```

To run the FastAPI app as Azure function locally, [install Azure Function Core Tools](https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=windows%2Cisolated-process%2Cnode-v4%2Cpython-v2%2Chttp-trigger%2Ccontainer-apps&pivots=programming-language-python). After that you can run the Azure function by:

```sh
func start
```
You can test the API via docs in http://127.0.0.1:7071/docs.
