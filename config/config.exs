import Config

config :trasa,
  ecto_repos: [Trasa.Repo],
  llm: Trasa.Rag.LLM.OpenAI

config :trasa, Trasa.Repo, types: Trasa.PostgresTypes

config :nx, :default_defn_options, compiler: EXLA

config :openai,
  api_key: System.get_env("OPENAI_API_KEY"),
  http_options: [recv_timeout: 30_000]

import_config "#{Mix.env()}.exs"
