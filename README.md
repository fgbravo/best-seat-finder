# Best Seat API
Best Seat API allows you to find the best possible seat in a venue given a JSON with the venue layout, available seats and number of requested seats.

# Requirements
- Ruby 2.6.6
- Rails 6.0.3
- Bundler 2.1.4

# Getting Started
Run the following commands inside your projects directory:
```sh
$ git clone https://github.com/fgbravo/best-seat-finder.git
# You might be asked for credentials to continue forward
$ cd best-seat-api
$ bundle install
$ rails db:create
$ rails server
```

# API
```
info:
    title: best-seat-api
    version: 1.0

servers:
    - url: http://localhost:3000/
    
paths:
    /available_seats:
    post:
        summary: Create a list of the best available seats
```

## Available Seats Endpoint

`POST /available_seats`

### Request Example:

```
curl -L -X POST 'http://localhost:3000/api/v1/available_seats' \
-H 'Content-Type: application/json' \
--data-raw '{
    "venue": {
        "layout": {
            "rows": 10,
            "columns": 50
        }
    },
    "seats": {
        "a1": {
            "id": "a1",
            "row": "a",
            "column": 1,
            "status": "AVAILABLE"
        },
        "b5": {
            "id": "b5",
            "row": "b",
            "column": 5,
            "status": "AVAILABLE"
        },
        "h7": {
            "id": "h7",
            "row": "h",
            "column": 7,
            "status": "AVAILABLE"
        }
    },
    "requested_seats": 1
}'
```

### Response Example
`201 Created`
```
[
    {
        "id": "a1",
        "row": "a",
        "column": 1,
        "status": "AVAILABLE"
    }
]
```

## Tests
To run the test suite of the project, simply run the following command:
```sh
$ rspec
```

