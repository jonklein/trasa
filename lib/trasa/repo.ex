defmodule Trasa.Repo do
  @moduledoc """
  The Ecto database repository for the Trasa application.
  """
  use Ecto.Repo,
    otp_app: :trasa,
    adapter: Ecto.Adapters.Postgres
end
