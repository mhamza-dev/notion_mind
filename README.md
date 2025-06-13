# NotionMind

NotionMind is an intelligent Slack bot that helps teams manage their work more efficiently by automatically creating structured tickets from Slack conversations. It uses GPT-4 to analyze conversations and generate well-formatted tickets with all necessary information.

## Features

- 🤖 Automatic ticket creation from Slack conversations
- 🧠 GPT-4 powered analysis of conversations
- 📝 Structured ticket format with:
  - Title
  - Description
  - Steps to reproduce
  - Expected behavior
  - Actual behavior
  - Priority
  - Labels
- 🔄 Real-time Slack integration
- 📊 Notion database integration
- 🔒 Secure API key management

## Prerequisites

- Elixir 1.14 or later
- Erlang/OTP 25 or later
- Node.js 18 or later
- PostgreSQL 12 or later
- OpenAI API key
- Slack App credentials
- Notion API key and database

## Local Development Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/notion_mind.git
   cd notion_mind
   ```

2. Install dependencies:

   ```bash
   mix deps.get
   cd assets && npm install && cd ..
   ```

3. Set up environment variables:

   ```bash
   cp .env.example .env
   ```

   Edit `.env` and add your API keys:

   ```
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

4. Set up the database:

   ```bash
   mix ecto.create
   mix ecto.migrate
   ```

5. Start the Phoenix server:

   ```bash
   mix phx.server
   ```

6. Visit [`localhost:4000`](http://localhost:4000) in your browser.

## Setting Up Notion

1. Create a new Notion database with the following properties:

   - Name (title)
   - Priority (select)
   - Status (status)
   - Labels (multi-select)

2. Share the database with your Notion integration
3. Copy the database ID from the URL
4. Add the database ID to your `.env` file

## Using NotionMind

1. Invite the bot to your Slack workspace
2. Mention the bot in a conversation with `@NotionMind`
3. The bot will analyze the conversation and create a ticket in Notion
4. The ticket will include:
   - A descriptive title
   - Detailed description
   - Steps to reproduce
   - Expected vs actual behavior
   - Priority level
   - Relevant labels

## Running Tests

```bash
mix test
```

## Documentation

Detailed documentation is available in the following locations:

- [Getting Started](docs/getting-started.md)
- [API Reference](docs/api-reference.md)
- [Slack Integration Guide](docs/slack-integration.md)
- [Notion Integration Guide](docs/notion-integration.md)
- [GPT Integration Guide](docs/gpt-integration.md)
- [Deployment Guide](docs/deployment.md)
- [Troubleshooting Guide](docs/troubleshooting.md)

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Phoenix Framework](https://www.phoenixframework.org/)
- [OpenAI](https://openai.com/)
- [Slack API](https://api.slack.com/)
- [Notion API](https://developers.notion.com/)

## Support

If you encounter any issues or have questions, please:

1. Check the [documentation](docs/)
2. Open an [issue](https://github.com/yourusername/notion_mind/issues)
3. Contact the maintainers

## Roadmap

- [ ] Custom ticket templates
- [ ] Multi-language support
- [ ] Team-specific configurations
- [ ] Analytics dashboard
- [ ] Automated ticket updates
- [ ] Integration with other project management tools

## Project Structure

```
notion_mind/
├── assets/              # Frontend assets
├── config/             # Configuration files
├── deps/               # Dependencies
├── docs/               # Documentation
├── lib/                # Application code
│   ├── notion_mind/    # Business logic
│   └── notion_mind_web/ # Web interface
├── priv/               # Database migrations, etc.
└── test/               # Test files
```

## Security

Please report any security issues to security@yourdomain.com.

## Authors

- Muhammad Hamza - Initial work - [YourGitHub](https://github.com/mhamza-dev)

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.
