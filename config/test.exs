import Config

config :erp, ErpWeb.Endpoint,
  http: [port: 4002],
  server: false

config :erp, Erp.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "erp_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :logger, level: :warning
