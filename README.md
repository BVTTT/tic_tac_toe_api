Tic-Tac-Toe API

# Setup

```
bundle install
```

# Endpoints

## Create a game

### Request:
```http
POST /games HTTP/1.1
Content-Type: application/json
Accept: application/json
Host: "whateverthehostis"
```

### Response

```http
Content-Type: application/json
Location: http://whateverthehostis/games/131231231

{
  "data": {
    "type": "game",
    "id": "131231231",
    "attributes": {
      "board": [
        [null, null, null],
        [null, null, null],
        [null, null, null]
      ]
    }
  },
  "links": {
    "self": "http://whateverthehostis/games/131231231"
  }
}
```
