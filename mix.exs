defmodule Trasa.MixProject do
  use Mix.Project

  def project do
    [
      app: :trasa,
      version: "0.1.0",
      elixir: "~> 1.16",
      aliases: aliases(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Trasa.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},
      {:bumblebee, "~> 0.5.3"},
      {:pgvector, "~> 0.2.0"},
      {:openai, "~> 0.6.1"},
      {:ortex, "~> 0.1"},
      {:exla, "~> 0.7.2"},
      {:nx, "~> 0.7.0"},
      {:ex_doc, "~> 0.31.0", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
