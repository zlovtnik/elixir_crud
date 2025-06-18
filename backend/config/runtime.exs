import Config

if System.get_env("DATABASE_URL") do
  config :erp, Erp.Repo,
    url: System.get_env("DATABASE_URL"),
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
else
  # When running in Docker, we need to use the service name as hostname
  if System.get_env("IN_DOCKER") do
    config :erp, Erp.Repo,
      username: System.get_env("POSTGRES_USER") || "postgres",
      password: System.get_env("POSTGRES_PASSWORD") || "postgres",
      hostname: "db",  # Use the service name from docker-compose
      database: System.get_env("POSTGRES_DB") || "erp_dev",
      pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
  end
end

if System.get_env("PORT") do
  port = String.to_integer(System.get_env("PORT"))
  config :erp, ErpWeb.Endpoint, http: [port: port]
end

if config_env() == :prod do
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  config :erp, ErpWeb.Endpoint,
    http: [
      port: String.to_integer(System.get_env("PORT") || "4000"),
      transport_options: [socket_opts: [:inet6]]
    ],
    secret_key_base: secret_key_base
end