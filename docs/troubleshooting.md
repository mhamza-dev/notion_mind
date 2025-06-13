# Troubleshooting Guide

This guide helps you resolve common issues with NotionMind.

## Common Issues

### Slack Integration Issues

#### Bot Not Responding

1. Check if the bot is online:

   ```
   /invite @NotionMind
   ```

2. Verify bot permissions:

   - Go to https://api.slack.com/apps
   - Select your app
   - Check "OAuth & Permissions"
   - Ensure all required scopes are added

3. Check environment variables:
   ```bash
   SLACK_BOT_TOKEN=your_bot_token
   SLACK_SIGNING_SECRET=your_signing_secret
   ```

#### Message Processing Errors

1. Check the application logs:

   ```bash
   tail -f log/notion_mind.log
   ```

2. Verify the conversation format:
   - Ensure the bot is mentioned
   - Check if the conversation is accessible to the bot
   - Verify the channel permissions

### Notion Integration Issues

#### Ticket Creation Fails

1. Check Notion API credentials:

   ```bash
   NOTION_API_KEY=your_api_key
   NOTION_DATABASE_ID=your_database_id
   ```

2. Verify database structure:

   - Check if all required properties exist
   - Ensure property names match exactly
   - Verify property types are correct

3. Check database permissions:
   - Ensure the integration has access
   - Verify the database is shared
   - Check workspace settings

#### Database Access Issues

1. Verify database ID:

   - Check the URL format
   - Ensure the ID is copied correctly
   - Try accessing the database manually

2. Check integration settings:
   - Verify the integration is active
   - Check workspace permissions
   - Review access logs

### GPT Integration Issues

#### Analysis Fails

1. Check OpenAI API key:

   ```bash
   OPENAI_API_KEY=your_api_key
   GPT_MODEL=gpt-4-turbo-preview
   ```

2. Verify API limits:

   - Check your quota
   - Review rate limits
   - Monitor usage

3. Check request format:
   - Verify conversation text
   - Check message length
   - Review API parameters

## Error Messages

### Slack Errors

```
Error: Invalid token
```

- Check your `SLACK_BOT_TOKEN`
- Verify the token is active
- Regenerate if necessary

```
Error: Channel not found
```

- Verify channel permissions
- Check if the bot is invited
- Review channel settings

### Notion Errors

```
Error: Invalid database ID
```

- Verify the database ID
- Check database access
- Ensure the ID is copied correctly

```
Error: Missing required property
```

- Check database structure
- Verify property names
- Review property types

### GPT Errors

```
Error: Invalid API key
```

- Check your OpenAI API key
- Verify the key is active
- Regenerate if necessary

```
Error: Rate limit exceeded
```

- Check your usage limits
- Implement rate limiting
- Contact OpenAI support

## Debugging

### Enable Debug Logging

1. Update your config:

   ```elixir
   config :logger, level: :debug
   ```

2. Check the logs:
   ```bash
   tail -f log/notion_mind.log
   ```

### Test API Connections

1. Test Slack API:

   ```bash
   curl -H "Authorization: Bearer $SLACK_BOT_TOKEN" https://slack.com/api/auth.test
   ```

2. Test Notion API:

   ```bash
   curl -H "Authorization: Bearer $NOTION_API_KEY" https://api.notion.com/v1/users/me
   ```

3. Test OpenAI API:
   ```bash
   curl -H "Authorization: Bearer $OPENAI_API_KEY" https://api.openai.com/v1/models
   ```

## Performance Issues

### Slow Response Times

1. Check API latency:

   - Monitor response times
   - Review API status pages
   - Check network connectivity

2. Optimize requests:
   - Batch API calls
   - Cache responses
   - Implement rate limiting

### High Resource Usage

1. Monitor system resources:

   ```bash
   top
   ```

2. Check database performance:

   ```bash
   mix ecto.migrations
   ```

3. Review application logs:
   ```bash
   tail -f log/notion_mind.log
   ```

## Getting Help

### Support Channels

1. GitHub Issues:

   - Open a new issue
   - Include error logs
   - Provide reproduction steps

2. Documentation:

   - Check the [Getting Started Guide](getting-started.md)
   - Review [API Reference](api-reference.md)
   - Read [Best Practices](best-practices.md)

3. Community Support:
   - Join our Slack community
   - Check Stack Overflow
   - Review GitHub discussions

### Reporting Issues

When reporting issues, include:

1. Error message
2. Steps to reproduce
3. Environment details
4. Log files
5. Expected behavior
6. Actual behavior

## Prevention

### Best Practices

1. Regular maintenance:

   - Update dependencies
   - Review API keys
   - Check permissions

2. Monitoring:

   - Set up alerts
   - Monitor logs
   - Track API usage

3. Security:
   - Rotate API keys
   - Review permissions
   - Update credentials

## Next Steps

- Read the [Getting Started Guide](getting-started.md)
- Check the [API Reference](api-reference.md)
- Review [Best Practices](best-practices.md)
