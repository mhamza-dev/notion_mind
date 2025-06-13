defmodule NotionMind.Repo do
  use Ecto.Repo,
    otp_app: :notion_mind,
    adapter: Ecto.Adapters.Postgres
end
