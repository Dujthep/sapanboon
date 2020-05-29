use Mix.Config

# Configure your database
config :sapanboon, Sapanboon.Repo,
  username: "postgres",
  password: "secret",
  database: "sapanboon_dev",
  hostname: "sapanboon.odds.team",
  port: "5433",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :sapanboon, SapanboonWeb.Endpoint,
  http: [port: 4000],
  debug_errors: false,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Watch static and templates for browser reloading.
config :sapanboon, SapanboonWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/sapanboon_web/{live,views}/.*(ex)$",
      ~r"lib/sapanboon_web/templates/.*(eex)$"
    ]
  ]

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

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: "581587157167-s2l0vlfofdj5f0uij76ln11o3toruohh.apps.googleusercontent.com", #made up code
  client_secret: "HlMNukHSTN9-z_O8WeDMUp8J" #made up code

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: "119501292726732",
  client_secret: "8224f14476e6b53e22d586dfce131764"

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :sapanboon, :api_transaction, "http://localhost:8080"
config :sapanboon, :admin_page, "http://localhost:4200/sapanboon/?uid="
config :sapanboon, :login_page, "http://localhost:4000/login"

config :sapanboon, :scb_payment,
  url_partners: "https://api-sandbox.partners.scb/partners/sandbox/v1",
  resource_owner_id: "l710fd5909bcb64676a0d58c9f4910a504",
  application_key: "l710fd5909bcb64676a0d58c9f4910a504",
  application_secret: "41b6f92fa6874e4bad0dfbda956735b6",
  ppId: "406242648868404"