import Config

# Configure your database
config :erp, Erp.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "erp_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Configure your application
config :erp, ecto_repos: [Erp.Repo]

# For development, we disable any cache and enable
# debugging and code reloading.
config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :erp, ErpWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ErpWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Erp.PubSub,
  live_view: [signing_salt: "your_signing_salt"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
