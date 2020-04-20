use Mix.Config

# Configure your database
config :sapanboon, Sapanboon.Repo,
  username: "postgres",
  password: "secret",
  database: "sapanboon_dev",
  hostname: "sapanboon.odds.team",
  port: "5433",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sapanboon, SapanboonWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
