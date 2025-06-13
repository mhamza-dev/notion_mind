# Getting Started with NotionMind

Welcome to NotionMind! This guide will help you set up and start using NotionMind in your team's workflow.

## Prerequisites

Before you begin, make sure you have:

1. A Slack workspace where you have admin privileges
2. A Notion account with API access
3. An OpenAI API key
4. Basic knowledge of command line operations

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/mhamza-dev/notion_mind.git
cd notion_mind
```

### 2. Install Dependencies

```bash
# Install Elixir dependencies
mix deps.get

# Install Node.js dependencies
cd assets && npm install && cd ..
```

### 3. Configure Environment Variables

Copy the example environment file and update it with your credentials:

```bash
cp .env.example .env
```

Edit the `.env` file with your API keys and configuration:

```env
# GPT Configuration
OPENAI_API_KEY=your_openai_api_key_here
GPT_MODEL=gpt-4-turbo-preview

# Notion Configuration
NOTION_API_KEY=your_notion_api_key_here
NOTION_DATABASE_ID=your_notion_database_id_here

# Slack Configuration
SLACK_CLIENT_ID=your_slack_client_id_here
SLACK_CLIENT_SECRET=your_slack_client_secret_here
SLACK_SIGNING_SECRET=your_slack_signing_secret_here
SLACK_BOT_TOKEN=your_slack_bot_token_here
```

### 4. Set Up the Database

```bash
mix ecto.create
mix ecto.migrate
```

### 5. Start the Server

```bash
mix phx.server
```

## Setting Up Notion

1. Create a new Notion database with these properties:

   - Name (title)
   - Priority (select)
   - Status (status)
   - Labels (multi-select)

2. Share the database with your Notion integration
3. Copy the database ID from the URL
4. Add the database ID to your `.env` file

## Setting Up Slack

1. Create a new Slack app at https://api.slack.com/apps
2. Add the following bot token scopes:

   - `app_mentions:read`
   - `channels:history`
   - `chat:write`
   - `groups:history`

3. Install the app to your workspace
4. Copy the bot token and add it to your `.env` file

## Using NotionMind

### Basic Usage

1. Invite the bot to a channel:

   ```
   /invite @NotionMind
   ```

2. Mention the bot in a conversation:

   ```
   @NotionMind please create a ticket for this issue
   ```

3. The bot will:
   - Analyze the conversation
   - Create a structured ticket in Notion
   - Post a confirmation message in Slack

### Ticket Format

Tickets created by NotionMind include:

- Title: A clear, concise description of the issue
- Description: Detailed explanation of the problem
- Steps to Reproduce: Numbered list of steps
- Expected Behavior: What should happen
- Actual Behavior: What actually happens
- Priority: Set based on conversation context
- Labels: Automatically generated from the conversation

## Troubleshooting

If you encounter issues:

1. Check the [Troubleshooting Guide](troubleshooting.md)
2. Verify your API keys and credentials
3. Check the application logs
4. Open an issue on GitHub

## Next Steps

- Read the [API Reference](api-reference.md)
- Learn about [Advanced Features](advanced-features.md)
- Check out [Best Practices](best-practices.md)

## Support

Need help? Check out:

- [Documentation Index](../docs/)
- [GitHub Issues](https://github.com/yourusername/notion_mind/issues)
- [Slack Community](https://slack.notionmind.com)
