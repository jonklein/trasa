defmodule Trasa.Rag.Document do
  @moduledoc """
  Defines the schema for a `Document` - the data our application
  will index and use to answer queries.
  """

  use Trasa, :model

  @doc """
  Defines the schema for the `Document` model.
  """
  schema "documents" do
    field(:text)
    timestamps()
  end

  @doc """
  Creates a changeset for a `Document` struct with given attributes.
  """
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
