defmodule NotionMindWeb.Clients.Notion do
  @moduledoc """
  Client for Notion API integration.
  Handles ticket creation and management in Notion databases.
  """

  @base_url "https://api.notion.com/v1"
  @version "2022-06-28"

  import NotionMindWeb.Clients.Request

  @doc """
  Creates a new ticket in Notion database from the analyzed conversation.

  ## Parameters
    - ticket: Map containing ticket information from GPT analysis
      %{
        "title" => "string",
        "description" => "string",
        "steps_to_reproduce" => ["string"],
        "expected_behavior" => "string",
        "actual_behavior" => "string",
        "priority" => "string",
        "labels" => ["string"]
      }

  ## Returns
    - `{:ok, response}` on success
    - `{:error, reason}` on failure
  """
  def create_ticket(ticket) do
    url = "#{@base_url}/pages"

    body = %{
      parent: %{
        database_id: Application.get_env(:notion_mind, :notion_database_id)
      },
      properties: format_ticket_properties(ticket),
      children: format_ticket_content(ticket)
    }

    url
    |> post_request(body, api_headers())
    |> handle_response()
  end

  defp format_ticket_properties(ticket) do
    %{
      "Name" => %{
        "title" => [
          %{
            "text" => %{
              "content" => ticket["title"]
            }
          }
        ]
      },
      "Priority" => %{
        "select" => %{
          "name" => ticket["priority"]
        }
      },
      "Status" => %{
        "status" => %{
          "name" => "To Do"
        }
      },
      "Labels" => %{
        "multi_select" =>
          Enum.map(ticket["labels"], fn label ->
            %{"name" => label}
          end)
      }
    }
  end

  defp format_ticket_content(ticket) do
    [
      %{
        "object" => "block",
        "type" => "heading_2",
        "heading_2" => %{
          "rich_text" => [
            %{
              "type" => "text",
              "text" => %{
                "content" => "Description"
              }
            }
          ]
        }
      },
      %{
        "object" => "block",
        "type" => "paragraph",
        "paragraph" => %{
          "rich_text" => [
            %{
              "type" => "text",
              "text" => %{
                "content" => ticket["description"]
              }
            }
          ]
        }
      },
      %{
        "object" => "block",
        "type" => "heading_2",
        "heading_2" => %{
          "rich_text" => [
            %{
              "type" => "text",
              "text" => %{
                "content" => "Steps to Reproduce"
              }
            }
          ]
        }
      },
      %{
        "object" => "block",
        "type" => "bulleted_list_item",
        "bulleted_list_item" => %{
          "rich_text" =>
            Enum.map(ticket["steps_to_reproduce"], fn step ->
              %{
                "type" => "text",
                "text" => %{
                  "content" => step
                }
              }
            end)
        }
      },
      %{
        "object" => "block",
        "type" => "heading_2",
        "heading_2" => %{
          "rich_text" => [
            %{
              "type" => "text",
              "text" => %{
                "content" => "Expected Behavior"
              }
            }
          ]
        }
      },
      %{
        "object" => "block",
        "type" => "paragraph",
        "paragraph" => %{
          "rich_text" => [
            %{
              "type" => "text",
              "text" => %{
                "content" => ticket["expected_behavior"]
              }
            }
          ]
        }
      },
      %{
        "object" => "block",
        "type" => "heading_2",
        "heading_2" => %{
          "rich_text" => [
            %{
              "type" => "text",
              "text" => %{
                "content" => "Actual Behavior"
              }
            }
          ]
        }
      },
      %{
        "object" => "block",
        "type" => "paragraph",
        "paragraph" => %{
          "rich_text" => [
            %{
              "type" => "text",
              "text" => %{
                "content" => ticket["actual_behavior"]
              }
            }
          ]
        }
      }
    ]
  end

  defp handle_response(response) do
    case response do
      {:ok, %{"object" => "page"} = body} ->
        {:ok, body}

      {:ok, %{"code" => code, "message" => message}} ->
        {:error, "Notion API error: #{code} - #{message}"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp api_headers do
    [
      {"Authorization", "Bearer #{Application.get_env(:notion_mind, :notion_api_key)}"},
      {"Notion-Version", @version},
      {"Content-Type", "application/json"}
    ]
  end
end
