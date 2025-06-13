defmodule NotionMindWeb.Clients.Slack do
  @moduledoc """
  Client for Slack API
  """

  import NotionMindWeb.Clients.Request

  @base_url "https://slack.com/api/"
  @conversations_replies_path "conversations.replies"

  def get_conversations_replies(channel_id, thread_ts) do
    params = %{channel: channel_id, ts: thread_ts}

    @conversations_replies_path
    |> api_url()
    |> get_request(params, api_headers())
    |> handle_response()
  end

  def extract_conversation_text(response) do
    case response do
      %{"ok" => true, "messages" => messages} ->
        text =
          messages
          |> Enum.map(&extract_message_text/1)
          |> Enum.reject(&is_nil/1)
          |> Enum.join("\n")

        {:ok, text}

      error ->
        error
    end
  end

  defp extract_message_text(%{"text" => text, "type" => "message"}) do
    # Remove user mentions like <@U090Y2ACB55>
    text
    |> String.replace(~r/<@[A-Z0-9]+>/, "")
    |> String.trim()
  end

  defp extract_message_text(_), do: nil

  defp api_url(path), do: @base_url <> path

  defp api_headers,
    do: [{"Authorization", "Bearer #{Application.get_env(:notion_mind, :slack_bot_token)}"}]

  defp handle_response(response) do
    case response do
      {:ok, %{"ok" => true} = body} ->
        {:ok, body}

      {:ok,
       %{
         "error" => error,
         "ok" => false,
         "response_metadata" => %{
           "messages" => messages
         }
       }} ->
        {:error, {error, messages}}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
