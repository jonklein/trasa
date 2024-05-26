defmodule Trasa.Rag.Context do
  @moduledoc """
  Defines the context for RAG in Trasa application.  This module loads
  and manages models & data used by RAG indexing & queries.  Because
  model loading is expensive, this module should be initialized once
  and reused for all RAG operations.
  """

  @embedding_model "thenlper/gte-small"

  @doc """
  Defines the structure of the Context with a single field:
  - `:embedding_model` which stores the loaded embedding model.
  """
  defstruct [:embedding_model]

  @doc """
  Creates a new context instance with the embedding model loaded.

  ## Returns
  - A new `%Trasa.Rag.Context{}` struct.
  """
  def new() do
    %__MODULE__{embedding_model: load_embedding_model()}
  end

  @doc false
  defp load_embedding_model do
    {:ok, model_info} = Bumblebee.load_model({:hf, @embedding_model})
    {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, @embedding_model})

    Bumblebee.Text.TextEmbedding.text_embedding(model_info, tokenizer,
      defn_options: [compiler: EXLA]
    )
  end
end
