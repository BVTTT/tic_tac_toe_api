Tic-Tac-Toe API

# Setup

```
bundle install
```

# Run tests

```
rspec
```

# Endpoints

## Home

### Request:
```http
GET / HTTP/1.1
Accept: application/json
Host: "whateverthehostis"
```

### Response

```http
HTTP/1.1 200 OK
Content-Type: application/json
Location: http://whateverthehostis/games/{{ id }}

{
  "links": {
    "games": "http://whateverthehostis/games"
  }
}
```

## Create a game

### Request:
```http
POST /games HTTP/1.1
Accept: application/json
Host: "whateverthehostis"

{
  "data": {
    "type": "games",
    "attributes": {
      "difficulty": "easy"
    }
  }
}
```

### Response

```http
HTTP/1.1 201 Created
Content-Type: application/json
Location: http://whateverthehostis/games/{{ id }}

{
  "data": {
    "type": "game",
    "id": "{{ id }}",
    "attributes": {
      "current_player": "cpu",
      "difficulty": "easy",
      "winner": null,
      "states": {
        "has_winner": false,
        "is_deadlocked": false,
        "is_over": false
      }
    }
  },
  "links": {
    "self": "http://whateverthehostis/games/{{ id }}",
    "current_player_moves": "http://whateverthehostis/games/{{ id }}/cpu_moves"
    "cpu_moves": "http://whateverthehostis/games/{{ id }}/cpu_moves",
    "user_moves": "http://whateverthehostis/games/{{ id }}/user_moves"
  }
}
```

## Get a game

### Request
```http
GET /games/{{ id }} HTTP/1.1
Content-Type: application/json
Accept: application/json
Host: "whateverthehostis"
```

### Response

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "data": {
    "type": "game",
    "id": "{{ id }}",
    "attributes": {
      "current_player": "cpu",
      "difficulty": "easy",
      "winner": null,
      "states": {
        "has_winner": false,
        "is_deadlocked": false,
        "is_over": false
      }
    }
  },
  "links": {
    "self": "http://whateverthehostis/games/{{ id }}",
    "current_player_moves": "http://whateverthehostis/games/{{ id }}/cpu_moves"
    "cpu_moves": "http://whateverthehostis/games/{{ id }}/cpu_moves",
    "user_moves": "http://whateverthehostis/games/{{ id }}/user_moves"
  }
}
```

## Delete a game

### Request
```http
DELETE /games/{{ id }} HTTP/1.1
Content-Type: application/json
Accept: application/json
Host: "whateverthehostis"
```

### Response

```http
HTTP/1.1 204 No Content
Content-Type: application/json
```


## Make CPU move

### Request

```http
PUT /games/{{ id }}/cpu_moves HTTP/1.1
Content-Type: application/json
Accept: application/json
Host: "whateverthehostis"
```

### Response

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "data": {
    "type": "game",
    "id": "{{ id }}",
    "attributes": {
      "current_player": "cpu",
      "difficulty": "easy",
      "winner": null,
      "states": {
        "has_winner": false,
        "is_deadlocked": false,
        "is_over": false
      }
    }
  },
  "links": {
    "self": "http://whateverthehostis/games/{{ id }}",
    "current_player_moves": "http://whateverthehostis/games/{{ id }}/cpu_moves"
    "cpu_moves": "http://whateverthehostis/games/{{ id }}/cpu_moves",
    "user_moves": "http://whateverthehostis/games/{{ id }}/user_moves"
  },
  "related": {
    "cpu_moves": {
      "played_position": [0, 1]
    }
  }
}
```

## Make User move

### Request

```http
PUT /games/{{ id }}/user_moves HTTP/1.1
Content-Type: application/json
Accept: application/json
Host: "whateverthehostis"
```

### Response

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "data": {
    "type": "game",
    "id": "{{ id }}",
    "attributes": {
      "current_player": "cpu",
      "difficulty": "easy",
      "winner": null,
      "states": {
        "has_winner": false,
        "is_deadlocked": false,
        "is_over": false
      }
    }
  },
  "links": {
    "self": "http://whateverthehostis/games/{{ id }}",
    "current_player_moves": "http://whateverthehostis/games/{{ id }}/cpu_moves"
    "cpu_moves": "http://whateverthehostis/games/{{ id }}/cpu_moves",
    "user_moves": "http://whateverthehostis/games/{{ id }}/user_moves"
  }
}
```

