defmodule NotionMindWeb.Clients.Gpt do
  @moduledoc """
  Client for GPT API
  """

  import NotionMindWeb.Clients.Request

  @base_url "https://api.openai.com/v1"
  @chat_completions_path "/chat/completions"

  @base_prompt """
  Analyze the following conversation and create a structured ticket with the following information:
  1. Title: A concise, descriptive title for the issue
  2. Description: A detailed description of the problem
  3. Steps to Reproduce: Numbered list of steps to reproduce the issue
  4. Expected Behavior: What should happen
  5. Actual Behavior: What is actually happening
  6. Priority: High/Medium/Low based on the impact
  7. Labels: Relevant labels for the ticket (e.g., bug, feature, enhancement)

  Format the response as a JSON object with these exact keys:
  {
    "title": "string",
    "description": "string",
    "steps_to_reproduce": ["string"],
    "expected_behavior": "string",
    "actual_behavior": "string",
    "priority": "string",
    "labels": ["string"]
  }

  Conversation:
  """

  def analyze_conversation(conversation_text, prompt) do
    messages = [
      %{
        role: "system",
        content: prompt
      },
      %{
        role: "user",
        content: conversation_text
      }
    ]

    dbg(messages)

    case get_response(messages) do
      {:ok, response} -> parse_response(response)
      error -> error
    end
  end

  def get_response(messages) do
    body = %{
      model: Application.get_env(:notion_mind, :gpt_model),
      messages: messages,
      temperature: 0.7,
      response_format: %{type: "json_object"}
    }

    headers = [
      {"Authorization", "Bearer #{Application.get_env(:notion_mind, :gpt_api_key)}"},
      {"Content-Type", "application/json"}
    ]

    "#{@base_url}#{@chat_completions_path}"
    |> post_request(body, headers)
    |> handle_response()
    |> dbg()
  end

  def analyse_prompt, do: @base_prompt

  defp handle_response(response) do
    case response do
      {:ok, %{"choices" => [%{"message" => %{"content" => content}} | _]}} ->
        {:ok, content}

      {:ok, %{"error" => %{"message" => message}}} ->
        {:error, message}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp parse_response(json_string) do
    case Jason.decode(json_string) do
      {:ok, parsed} -> {:ok, parsed}
      {:error, _} -> {:error, "Failed to parse GPT response"}
    end
  end
end
