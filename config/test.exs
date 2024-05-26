import Config

config :trasa, Trasa.Repo,
  username: "postgres",
  password: "postgres",
  database: "trasa_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
