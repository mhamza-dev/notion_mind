defmodule NotionMindWeb.Clients.Request do
  @moduledoc """
  A robust HTTP client wrapper around HTTPoison for making HTTP requests.

  ## Features
  - Supports GET, POST, PUT, DELETE methods
  - Automatic JSON encoding/decoding
  - Query parameter support
  - Configurable timeouts and SSL options
  - Comprehensive error handling
  """

  use HTTPoison.Base

  @default_headers [
    {"Content-Type", "application/json"},
    {"Accept", "application/json"}
  ]

  @default_options [
    timeout: 30_000,
    recv_timeout: 30_000,
    ssl: [{:versions, [:"tlsv1.2"]}]
  ]

  @doc """
  Makes a GET request to the specified URL.

  ## Parameters
    - url: The URL to make the request to
    - query_params: Optional map of query parameters
    - headers: Optional list of headers
    - options: Optional HTTPoison options

  ## Returns
    - `{:ok, body}` on success
    - `{:error, reason}` on failure
  """
  def get_request(url, query_params \\ %{}, headers \\ [], options \\ []) do
    url
    |> add_query_params(query_params)
    |> HTTPoison.get(merge_headers(headers), merge_options(options))
    |> handle_response()
  end

  @doc """
  Makes a POST request to the specified URL.

  ## Parameters
    - url: The URL to make the request to
    - body: The request body (map or binary)
    - headers: Optional list of headers
    - options: Optional HTTPoison options

  ## Returns
    - `{:ok, body}` on success
    - `{:error, reason}` on failure
  """
  def post_request(url, body \\ %{}, headers \\ [], options \\ [])

  def post_request(url, body, headers, options) when is_map(body) do
    url
    |> HTTPoison.post(
      Jason.encode!(body),
      merge_headers(headers),
      merge_options(options)
    )
    |> handle_response()
  end

  def post_request(url, body, headers, options) when is_binary(body) do
    url
    |> HTTPoison.post(
      body,
      merge_headers(headers),
      merge_options(options)
    )
    |> handle_response()
  end

  @doc """
  Makes a PUT request to the specified URL.

  ## Parameters
    - url: The URL to make the request to
    - body: The request body (map or binary)
    - headers: Optional list of headers
    - options: Optional HTTPoison options

  ## Returns
    - `{:ok, body}` on success
    - `{:error, reason}` on failure
  """
  def put_request(url, body \\ %{}, headers \\ [], options \\ [])

  def put_request(url, body, headers, options) when is_map(body) do
    url
    |> HTTPoison.put(
      Jason.encode!(body),
      merge_headers(headers),
      merge_options(options)
    )
    |> handle_response()
  end

  def put_request(url, body, headers, options) when is_binary(body) do
    url
    |> HTTPoison.put(
      body,
      merge_headers(headers),
      merge_options(options)
    )
    |> handle_response()
  end

  @doc """
  Makes a DELETE request to the specified URL.

  ## Parameters
    - url: The URL to make the request to
    - headers: Optional list of headers
    - options: Optional HTTPoison options

  ## Returns
    - `{:ok, body}` on success
    - `{:error, reason}` on failure
  """
  def delete_request(url, headers \\ [], options \\ []) do
    url
    |> HTTPoison.delete(merge_headers(headers), merge_options(options))
    |> handle_response()
  end

  # Private helper functions

  defp add_query_params(url, params) when map_size(params) == 0, do: url

  defp add_query_params(url, params) do
    params
    |> Enum.reduce("#{url}?", fn {key, value}, acc ->
      updated_key = if is_atom(key), do: Atom.to_string(key), else: key
      acc <> "#{updated_key}=#{value}&"
    end)
    |> String.trim_trailing("&")
    |> IO.inspect(label: "url")
  end

  defp merge_headers(headers) do
    @default_headers ++ headers
  end

  defp merge_options(options) do
    Keyword.merge(@default_options, options)
  end

  defp handle_response(response) do
    case response do
      {:ok, %{body: body}} ->
        parse_json(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp parse_json(""), do: {:ok, ""}

  defp parse_json(body) do
    case Jason.decode(body) do
      {:ok, result} -> {:ok, result}
      {:error, _} -> {:error, :invalid_json}
    end
  end
end
