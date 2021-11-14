# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :webscraper,
  ecto_repos: [Webscraper.Repo]

# Configures the endpoint
config :webscraper, WebscraperWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dUEUtAzVuYmsn/CRa6p5lofjyDQ+DKIqti01dffs4aiH5owlkXTKOAMwWz5jtPCQ",
  render_errors: [view: WebscraperWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Webscraper.PubSub,
  live_view: [signing_salt: "4Xo5dn5C"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
