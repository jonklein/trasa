defmodule Trasa.Rag do
  @moduledoc """
  Provides core functionalities for handling documents and embeddings within the Trasa application.
  This module includes functions to create documents, create embeddings, query embeddings, and retrieve embedding contexts.
  """

  import Ecto.Query
  import Pgvector.Ecto.Query

  alias Trasa.Rag.{EmbeddingVector, Embedding, Document, LLM}

  @doc """
  Creates a new document with the given fields.

  ## Parameters
  - `fields`: A map containing the fields required to create a document.

  ## Returns
  - The result of inserting a new document into the repository.
  """
  def create_document(fields) do
    %Document{}
    |> Document.changeset(fields)
    |> Trasa.Repo.insert()
  end

  @doc """
  Creates a new embedding with the given fields.

  ## Parameters
  - `fields`: A map containing the fields required to create an embedding.

  ## Returns
  - The result of inserting a new embedding into the repository.
  """
  def create_embedding(fields) do
    %Embedding{}
    |> Embedding.changeset(fields)
    |> Trasa.Repo.insert()
  end

  @doc """
  Processes a query using the given context to complete the query with embeddings.

  ## Parameters
  - `context`: The context containing the embedding model.
  - `query`: The query text to be processed.

  ## Returns
  - The completed query after processing with embeddings.
  """
  def query(context, query) do
    context
    |> EmbeddingVector.embedding(query)
    |> embedding_context_by_vector()
    |> LLM.complete(query)
  end

  @doc """
  Finds embeddings closest to the given query vector, ordered by cosine distance.

  ## Parameters
  - `query`: The query vector to find closest embeddings for.
  - `limit`: The maximum number of embeddings to return (default is 5).

  ## Returns
  - A list of embeddings ordered by their cosine distance to the query vector.
  """
  def find_embeddings_by_vector(query, limit \\ 5) do
    from(i in Embedding, order_by: cosine_distance(i.vector, ^query), limit: ^limit)
    |> Trasa.Repo.all()
  end

  @doc """
  Retrieves the textual context from embeddings closest to the given query vector.

  ## Parameters
  - `query`: The query vector to find textual contexts for.

  ## Returns
  - A string representing the concatenated texts of the closest embeddings.
  """
  def embedding_context_by_vector(query) do
    find_embeddings_by_vector(query)
    |> Enum.map(& &1.text)
    |> Enum.join()
  end
end
