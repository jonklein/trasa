defmodule Trasa.Rag.Embedding do
  @moduledoc """
  Defines the schema and changeset for `Embedding` - the chunked text of
  a `Document` along with the query-able embedding vector.
  """

  use Trasa, :model

  @doc """
  Defines the schema for embeddings in the database.
  """
  schema "embeddings" do
    field(:vector, Pgvector.Ecto.Vector)
    field(:text, :string)
    belongs_to(:document, Trasa.Rag.Document)
    timestamps()
  end

  @doc """
  Creates a changeset for an embedding with given attributes.
  """
  def changeset(embedding, attrs) do
    embedding
    |> cast(attrs, [:vector, :text, :document_id])
    |> validate_required([:vector, :text, :document_id])
  end
end
