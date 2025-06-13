# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :notion_mind,
  ecto_repos: [NotionMind.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :notion_mind, NotionMindWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: NotionMindWeb.ErrorHTML, json: NotionMindWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: NotionMind.PubSub,
  live_view: [signing_salt: "2nsNu4yb"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :notion_mind, NotionMind.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  notion_mind: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  notion_mind: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures clients
config :notion_mind,
  # GPT
  gpt_model: System.get_env("GPT_MODEL"),
  gpt_api_key: System.get_env("OPENAI_API_KEY"),

  # Notion
  notion_api_key: System.get_env("NOTION_API_KEY"),

  # Slack
  slack_client_id: System.get_env("SLACK_CLIENT_ID"),
  slack_client_secret: System.get_env("SLACK_CLIENT_SECRET"),
  slack_signing_secret: System.get_env("SLACK_SIGNING_SECRET"),
  slack_bot_token: System.get_env("SLACK_BOT_TOKEN")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
