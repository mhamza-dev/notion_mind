<p align="center">
  <img src="../priv/static/images/logo.svg" alt="NotionMind Logo" width="100" height="auto"/>
  <br/>
  <img src="https://github.com/mhamza-dev.png" alt="Hamza's GitHub Profile" width="48" height="48" style="border-radius:50%;margin-top:8px;"/>
</p>

# Getting Started with NotionMind

Welcome to NotionMind! This guide will help you set up and use the intelligent Slack-to-Notion ticketing bot.

---

**Author:** [Muhammad Hamza](https://github.com/mhamza-dev)

---

## Prerequisites

- Elixir 1.14+
- Erlang/OTP 25+
- Node.js 18+
- PostgreSQL 12+
- OpenAI API key
- Slack App credentials
- Notion API key and database

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/mhamza-dev/notion_mind.git
   cd notion_mind
   ```
2. **Install dependencies:**
   ```bash
   mix deps.get
   cd assets && npm install && cd ..
   ```
3. **Set up environment variables:**
   ```bash
   cp .env.example .env
   # Edit .env and add your API keys
   ```
4. **Set up the database:**
   ```bash
   mix ecto.create
   mix ecto.migrate
   ```
5. **Start the Phoenix server:**
   ```bash
   mix phx.server
   ```
6. **Visit [`localhost:4000`](http://localhost:4000) in your browser.**

## Configuration

- **Notion:** Create a Notion database with properties: Name (title), Priority (select), Status (status), Labels (multi-select). Share it with your integration and add the database ID to `.env`.
- **Slack:** Create a Slack app, add bot token scopes, install it to your workspace, and add credentials to `.env`.
- **OpenAI:** Add your OpenAI API key and model to `.env`.

## Basic Usage

1. Invite the bot to your Slack workspace.
2. Mention the bot in a conversation with `@NotionMind`.
3. The bot will analyze the conversation and create a ticket in Notion.
4. The ticket will include title, description, steps to reproduce, expected/actual behavior, priority, and labels.

---

For more details, see the [API Reference](api-reference.md), [Best Practices](best-practices.md), and [Troubleshooting](troubleshooting.md).

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
