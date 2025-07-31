# SignalWire Coding Challenge – Ticket and Tag API

This is a small Rails API project built as part of the SignalWire coding challenge. It implements a single endpoint that validates and processes ticket data, tracks tags, and sends a webhook based on tag frequency.

## Features

- Accepts a JSON payload with `user_id`, `title`, and `tags`.
- Validates presence of `user_id` and `title`.
- Ensures `tags` array contains fewer than 5 items (case-insensitive).
- Persists ticket info to a `tickets` table with a timestamp.
- Tracks cumulative counts of tags in a `tags` table.
- Sends a webhook to a test URL with the most frequent tag.

## Tech Stack

- Ruby on Rails 7.x
- PostgreSQL (or SQLite for dev/test)
- RSpec for testing
- Net::HTTP for webhook calls

## API Endpoint

### `POST /tickets`

**Request Body Example**:

```json
{
  "user_id": 1234,
  "title": "My title",
  "tags": ["tag1", "tag2"]
}
