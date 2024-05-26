ExUnit.start(exclude: [:skip])
Ecto.Adapters.SQL.Sandbox.mode(Trasa.Repo, :manual)
System.put_env("ENVIRONMENT", "test")
