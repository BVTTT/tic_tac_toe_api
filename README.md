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
      ],
      "current_player": "cpu"
    }
  },
  "links": {
    "self": "http://whateverthehostis/games/131231231",
    "current_player_moves": "http://whateverthehostis/games/131231231/cpu_moves"
  }
}
```

## Get a game

### Request
```http
GET /games/131231231 HTTP/1.1
Content-Type: application/json
Accept: application/json
Host: "whateverthehostis"
```

### Response

```http
Content-Type: application/json

{
  "data": {
    "type": "game",
    "id": "131231231",
    "attributes": {
      "board": [
        [null, null, null],
        [null, null, null],
        [null, null, null]
      ],
      "current_player": "cpu"
    }
  },
  "links": {
    "self": "http://whateverthehostis/games/131231231",
    "current_player_moves": "http://whateverthehostis/games/131231231/cpu_moves"
  }
}
```

## Make CPU move

### Request

```http
PUT /games/131231231/cpu_moves HTTP/1.1
Content-Type: application/json
Accept: application/json
Host: "whateverthehostis"
```

### Response

```http
Content-Type: application/json

{
  "data": {
    "type": "game",
    "id": "131231231",
    "attributes": {
      "board": [
        [null, "cpu", null],
        [null, null, null],
        [null, null, null]
      ],
      "current_player": "user"
    }
  },
  "links": {
    "self": "http://whateverthehostis/games/131231231",
    "current_player_moves": "http://whateverthehostis/games/131231231/user_moves"
  },
  "related": {
    "cpu_moves": {
      "played_position": [0, 1]
    }
  }
}
```

