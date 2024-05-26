defmodule Trasa.Rag.EmbeddingVector do
  @moduledoc """
  Provides functionality for generating embeddings for text and text chunks using a pre-loaded embedding model.
  """

  @doc """
  Computes the embedding for a given text using the specified context's embedding model.

  ## Parameters
  - `context`: The context containing the embedding model.
  - `text`: The text for which the embedding is to be computed.

  ## Returns
  - The embedding vector.
  """
  def embedding(context, text) do
    %{embedding: embedding} = Nx.Serving.run(context.embedding_model, text)
    embedding
  end

  @doc """
  Computes embeddings for chunks of text, splitting the text into specified sizes.

  ## Parameters
  - `context`: The context containing the embedding model.
  - `text`: The text to be split and embedded.
  - `chunk_size`: The size of each text chunk (default is 1024).

  ## Returns
  - A stream of tuples, each containing a chunk of text and its corresponding embedding.
  """
  def embedding_chunks(context, text, chunk_size \\ 1024) do
    text
    |> String.codepoints()
    |> Enum.chunk_every(chunk_size)
    |> Enum.map(&Enum.join/1)
    |> Stream.map(&{&1, embedding(context, &1)})
  end
end
