defmodule NotionMind.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NotionMindWeb.Telemetry,
      NotionMind.Repo,
      {DNSCluster, query: Application.get_env(:notion_mind, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: NotionMind.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: NotionMind.Finch},
      # Start a worker by calling: NotionMind.Worker.start_link(arg)
      # {NotionMind.Worker, arg},
      # Start to serve requests, typically the last entry
      NotionMindWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NotionMind.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NotionMindWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
