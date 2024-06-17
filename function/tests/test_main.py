import pytest
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"Hello": "World"}

@pytest.mark.parametrize("item_id, query, expected_status, expected_response", [
    (1, None, 200, {"item_id": 1, "q": None}),
    (2, "test", 200, {"item_id": 2, "q": "test"}),
    (3, "", 200, {"item_id": 3, "q": ""}),
])
def test_read_item(item_id, query, expected_status, expected_response):
    if query is not None:
        response = client.get(f"/items/{item_id}", params={"q": query})
    else:
        response = client.get(f"/items/{item_id}")

    assert response.status_code == expected_status
    assert response.json() == expected_response
