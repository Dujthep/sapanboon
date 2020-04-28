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

# Config Sending Email with SMTP
config :sapanboon, Sapanboon.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.gmail.com",
  port: 587,
  username: "sapanboon.dev@gmail.com",
  password: "Sapanboon1$",
  tls: :if_available, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 1

config :sapanboon, :api_transaction, "http://localhost:8080"
config :sapanboon, :admin_page, "http://localhost:4200/sapanboon/?uid="
config :sapanboon, :login_page, "http://localhost:4000/login"

config :sapanboon,
  http_adapter: Http.Mock
