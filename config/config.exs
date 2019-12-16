# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sapanboon,
  ecto_repos: [Sapanboon.Repo]

# Configures the endpoint
config :sapanboon, SapanboonWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rXSOy4rdwiT+gUB2kzOHKm4Mm2aLJaaG13s8KNsibBwFyP7996NcvNO43AfIiGVL",
  render_errors: [view: SapanboonWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sapanboon.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
