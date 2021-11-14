defmodule Webscraper.Repo do
  use Ecto.Repo,
    otp_app: :webscraper,
    adapter: Ecto.Adapters.Postgres
end
