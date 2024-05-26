defmodule Trasa do
  @moduledoc """
  Macros and functions for the Trasa application.
  """

  def model do
    quote do
      require Ecto.Query

      use Ecto.Schema
      import Ecto.Changeset

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @timestamps_opts [type: :utc_datetime]
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  defmacro __using__(opts) do
    apply(__MODULE__, opts[:which], [opts])
  end
end
