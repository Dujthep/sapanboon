use Mix.Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.
config :sapanboon, SapanboonWeb.Endpoint,
  load_from_system_env: true,
  url: [
    host: System.get_env("APP_HOSTNAME") || "127.0.0.1",
    port: 80
  ],
  check_origin: [
    "//api.sapanboon.org",
  ],
  cache_static_manifest: "priv/static/cache_manifest.json",
  show_sensitive_data_on_connection_error: true

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
  username: "admin@sapanboon.org",
  password: "chat8884",
  tls: :if_available, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 1

# Do not print debug messages in production
config :logger, level: :info

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: "564400817451-0iq7vgs7b4r8u35r7kv0ft29pdrjbtud.apps.googleusercontent.com", #made up code
  client_secret: "4gCA_f7wy1GJeIJevsOTmQYs" #made up code

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: "982418975482839",
  client_secret: "3e665b36d3259ea5091542b4ad987172"

config :sapanboon, :api_transaction, "https://api.sapanboon.org"
config :sapanboon, :admin_page, "https://admin.sapanboon.org/sapanboon/?uid="
config :sapanboon, :login_page, "https://sapanboon.org/login"