# Notion Integration Guide

This guide explains how to set up and use NotionMind with your Notion workspace.

## Setting Up Notion

### 1. Create a Notion Integration

1. Go to https://www.notion.so/my-integrations
2. Click "New integration"
3. Name your integration (e.g., "NotionMind")
4. Select the workspace where you want to use the integration
5. Click "Submit"
6. Copy the "Internal Integration Token" - you'll need this for your `.env` file

### 2. Create a Database

1. Create a new page in your Notion workspace
2. Click "Add a database"
3. Choose "Table" as the database type
4. Add the following properties:

   | Property Name | Type         | Description           |
   | ------------- | ------------ | --------------------- |
   | Name          | Title        | Ticket title          |
   | Priority      | Select       | Ticket priority level |
   | Status        | Status       | Current ticket status |
   | Labels        | Multi-select | Categorization tags   |

5. Configure the properties:

   **Priority (Select)**

   - High
   - Medium
   - Low

   **Status (Status)**

   - To Do
   - In Progress
   - Done

   **Labels (Multi-select)**

   - Bug
   - Feature
   - Enhancement
   - Documentation
   - Question

### 3. Share the Database

1. Click "Share" in the top right corner
2. Click "Add connections"
3. Select your NotionMind integration
4. Click "Confirm"

### 4. Get the Database ID

1. Open your database in Notion
2. Copy the ID from the URL:
   ```
   https://www.notion.so/workspace/[DATABASE_ID]?v=...
   ```
3. Add this ID to your `.env` file as `NOTION_DATABASE_ID`

## Ticket Structure

NotionMind creates tickets with the following structure:

### Properties

- **Name**: A clear, concise title generated from the conversation
- **Priority**: Automatically determined based on conversation context
- **Status**: Set to "To Do" by default
- **Labels**: Automatically generated from the conversation content

### Content

The ticket content is organized into sections:

1. **Description**

   - Detailed explanation of the issue
   - Context from the conversation
   - Any relevant links or references

2. **Steps to Reproduce**

   - Numbered list of steps
   - Clear and concise instructions
   - Any prerequisites or setup required

3. **Expected Behavior**

   - What should happen
   - How the system should respond
   - Any expected outputs or results

4. **Actual Behavior**
   - What actually happens
   - Any error messages or unexpected behavior
   - Screenshots or logs (if mentioned in conversation)

## Best Practices

1. **Database Organization**

   - Use views to organize tickets by status, priority, or labels
   - Create filters to focus on specific types of tickets
   - Use sorting to prioritize important tickets

2. **Labels**

   - Keep labels consistent and meaningful
   - Use labels to categorize tickets effectively
   - Avoid creating too many labels

3. **Priority Levels**
   - Use priority levels consistently
   - Consider creating a priority guide for your team
   - Review and adjust priorities regularly

## Troubleshooting

### Common Issues

1. **Integration Not Working**

   - Verify the integration token is correct
   - Check if the integration has access to the database
   - Ensure the database ID is correct

2. **Missing Properties**

   - Verify all required properties exist in the database
   - Check property names match exactly
   - Ensure property types are correct

3. **Permission Issues**
   - Check if the integration has proper permissions
   - Verify the database is shared with the integration
   - Ensure the workspace allows integrations

### Getting Help

If you encounter issues:

1. Check the [Troubleshooting Guide](troubleshooting.md)
2. Review the [Notion API Documentation](https://developers.notion.com/)
3. Open an issue on GitHub
4. Contact support

## Advanced Features

### Custom Properties

You can add custom properties to your database:

1. Click the "+" button in the database header
2. Choose the property type
3. Name the property
4. Configure the property settings

### Database Views

Create different views for your database:

1. Click "Add a view" in the database header
2. Choose a view type (Table, Board, Calendar, etc.)
3. Configure the view settings
4. Save the view

### Automation

NotionMind can be integrated with other Notion automations:

1. Use Notion's built-in automation features
2. Connect with other tools via the Notion API
3. Create custom workflows

## Security Considerations

1. Keep your integration token secure
2. Regularly review integration permissions
3. Monitor database access
4. Use appropriate access controls

## Next Steps

- Learn about [Advanced Features](advanced-features.md)
- Read the [API Reference](api-reference.md)
- Check out [Best Practices](best-practices.md)
