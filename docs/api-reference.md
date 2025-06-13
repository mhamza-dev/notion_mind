# API Reference

This document provides detailed information about NotionMind's API endpoints and integration points.

## Slack Integration

### Event Subscriptions

#### App Mention Event

```
POST /api/slack/webhook
```

Handles Slack app mention events and creates tickets.

**Request Body:**

```json
{
  "event": {
    "type": "app_mention",
    "text": "<@BOT_ID> create ticket",
    "channel": "CHANNEL_ID",
    "ts": "TIMESTAMP"
  }
}
```

**Response:**

```json
{
  "ok": true,
  "message": "Ticket created successfully"
}
```

## Notion Integration

### Create Ticket

```
POST /api/notion/pages
```

Creates a new ticket in Notion.

**Request Body:**

```json
{
  "parent": {
    "database_id": "DATABASE_ID"
  },
  "properties": {
    "Name": {
      "title": [
        {
          "text": {
            "content": "Ticket Title"
          }
        }
      ]
    },
    "Priority": {
      "select": {
        "name": "High"
      }
    },
    "Status": {
      "status": {
        "name": "To Do"
      }
    },
    "Labels": {
      "multi_select": [
        {
          "name": "Bug"
        }
      ]
    }
  }
}
```

**Response:**

```json
{
  "object": "page",
  "id": "PAGE_ID",
  "created_time": "TIMESTAMP",
  "last_edited_time": "TIMESTAMP"
}
```

## GPT Integration

### Analyze Conversation

```
POST /api/gpt/analyze
```

Analyzes a conversation and generates ticket information.

**Request Body:**

```json
{
  "conversation": "Conversation text",
  "model": "gpt-4-turbo-preview"
}
```

**Response:**

```json
{
  "title": "Ticket Title",
  "description": "Detailed description",
  "steps_to_reproduce": ["Step 1", "Step 2"],
  "expected_behavior": "Expected behavior",
  "actual_behavior": "Actual behavior",
  "priority": "High",
  "labels": ["Bug", "Feature"]
}
```

## Environment Variables

### Required Variables

```bash
# GPT Configuration
OPENAI_API_KEY=your_openai_api_key
GPT_MODEL=gpt-4-turbo-preview

# Notion Configuration
NOTION_API_KEY=your_notion_api_key
NOTION_DATABASE_ID=your_database_id

# Slack Configuration
SLACK_CLIENT_ID=your_client_id
SLACK_CLIENT_SECRET=your_client_secret
SLACK_SIGNING_SECRET=your_signing_secret
SLACK_BOT_TOKEN=your_bot_token
```

## Error Codes

### HTTP Status Codes

- `200 OK`: Request successful
- `400 Bad Request`: Invalid request parameters
- `401 Unauthorized`: Invalid or missing API key
- `403 Forbidden`: Insufficient permissions
- `404 Not Found`: Resource not found
- `429 Too Many Requests`: Rate limit exceeded
- `500 Internal Server Error`: Server error

### Error Response Format

```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Error description"
  }
}
```

## Rate Limits

- Slack API: 50 requests per minute
- Notion API: 3 requests per second
- OpenAI API: 60 requests per minute

## Authentication

### Slack Authentication

```bash
curl -H "Authorization: Bearer $SLACK_BOT_TOKEN" https://slack.com/api/auth.test
```

### Notion Authentication

```bash
curl -H "Authorization: Bearer $NOTION_API_KEY" https://api.notion.com/v1/users/me
```

### OpenAI Authentication

```bash
curl -H "Authorization: Bearer $OPENAI_API_KEY" https://api.openai.com/v1/models
```

## Webhooks

### Slack Events

Configure the following event subscriptions:

- `app_mention`
- `message.channels`
- `message.groups`
- `message.im`
- `message.mpim`

### Notion Updates

Notion webhooks are not currently supported.

## SDK Support

NotionMind is built with:

- Elixir 1.14+
- Phoenix Framework
- HTTPoison
- Jason

## Examples

### Creating a Ticket

```elixir
NotionMindWeb.Clients.Notion.create_ticket(%{
  "title" => "Bug in login system",
  "description" => "Users cannot log in",
  "steps_to_reproduce" => ["1. Click login", "2. Enter credentials"],
  "expected_behavior" => "User should be logged in",
  "actual_behavior" => "Error message appears",
  "priority" => "High",
  "labels" => ["Bug", "Authentication"]
})
```

### Analyzing a Conversation

```elixir
NotionMindWeb.Clients.GPT.analyze_conversation("User reported login issues")
```

## Best Practices

1. Always handle API errors gracefully
2. Implement rate limiting
3. Cache responses when appropriate
4. Use proper error handling
5. Monitor API usage

## Support

For API support:

1. Check the [Troubleshooting Guide](troubleshooting.md)
2. Review the [Getting Started Guide](getting-started.md)
3. Open an issue on GitHub
