
import Config

config :trasa, Trasa.Repo,
  username: "postgres",
  password: "postgres",
  database: "trasa_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
