defmodule Trasa.Rag.Indexing do
  @moduledoc """
  Provides functionality for indexing documents by processing their text into embeddings
  and storing these embeddings in the database.
  """

  alias Trasa.Rag.{EmbeddingVector, Embedding}

  import Ecto.Query

  @doc """
  Indexes all documents in the database by processing their text into embeddings.

  ## Parameters
  - `context`: a Trasa.Rag.Context context.

  ## Details
  - Retrieves all documents from the database.
  - Processes each document to extract embeddings and stores them.
  """
  def index_all(context) do
    Trasa.Repo.all(Trasa.Rag.Document)
    |> Enum.each(&index_document(context, &1))
  end

  @doc """
  Indexes a single document by processing its text into embeddings and storing these embeddings.

  ## Parameters
  - `context`: a Trasa.Rag.Context context.
  - `document`: The document to be indexed.

  ## Details
  - Deletes existing embeddings for the document.
  - Processes the document's text to extract embeddings.
  - Stores each embedding in the database.
  """
  def index_document(context, document) do
    from(e in Embedding, where: e.document_id == ^document.id)
    |> Trasa.Repo.delete_all()

    context
    |> EmbeddingVector.embedding_chunks(document.text)
    |> Stream.map(fn {text, embedding} ->
      Trasa.Rag.create_embedding(%{document_id: document.id, vector: embedding, text: text})
    end)
    |> Stream.run()
  end
end
