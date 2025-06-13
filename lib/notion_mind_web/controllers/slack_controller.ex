defmodule NotionMindWeb.SlackController do
  use NotionMindWeb, :controller

  alias NotionMindWeb.Clients.{Slack, Gpt}

  def webhook(conn, %{"challenge" => challenge} = _params) do
    # Respond to Slack's challenge request
    conn
    |> send_resp(:ok, challenge)
  end

  def webhook(
        conn,
        %{
          "event" => %{
            "type" => "app_mention",
            "channel" => channel,
            "thread_ts" => thread_ts
          }
        } = _params
      ) do
    with {:ok, response} <- Slack.get_conversations_replies(channel, thread_ts),
         {:ok, conversation_text} <- Slack.extract_conversation_text(response),
         {:ok, ticket} <- Gpt.analyze_conversation(conversation_text, Gpt.analyse_prompt()) do
      # Format the ticket information for Slack
      message = format_ticket_message(ticket)
      dbg(message)

      conn
      |> put_status(:ok)
    else
      {:error, reason} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Failed to process conversation: #{inspect(reason)}"})
    end
  end

  def webhook(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{text: "Event type not supported"})
  end

  defp format_ticket_message(ticket) do
    """
    *Ticket Analysis*

    *Title:* #{ticket["title"]}
    *Priority:* #{ticket["priority"]}
    *Labels:* #{Enum.join(ticket["labels"], ", ")}

    *Description:*
    #{ticket["description"]}

    *Steps to Reproduce:*
    #{Enum.map_join(ticket["steps_to_reproduce"], "\n", &"• #{&1}")}

    *Expected Behavior:*
    #{ticket["expected_behavior"]}

    *Actual Behavior:*
    #{ticket["actual_behavior"]}
    """
  end
end
