defmodule Trasa.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Trasa.Repo
    ]

    opts = [strategy: :one_for_one, name: Trasa.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
