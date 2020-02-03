# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sapanboon, Sapanboon.Repo,
  database: "sapanboon_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"

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

config :ueberauth, Ueberauth,
  providers: [
    google: { Ueberauth.Strategy.Google, [default_scope: "email profile plus.me"] },
    facebook: { Ueberauth.Strategy.Facebook, [default_scope: "email public_profile"] },
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: "581587157167-s2l0vlfofdj5f0uij76ln11o3toruohh.apps.googleusercontent.com", #made up code 
  client_secret: "HlMNukHSTN9-z_O8WeDMUp8J" #made up code

# config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
#   client_id: "119501292726732",
#   client_secret: "8224f14476e6b53e22d586dfce131764"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
