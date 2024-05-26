defmodule Trasa.Rag.LLMProvider do
  @moduledoc """
  Defines a simple callback interface for LLM providers.
  """

  @doc """
  Completes a given text string using a language model.

  ## Parameters
  - `context`: The context or configuration for the language model.
  - `text`: The initial text to be completed.

  ## Returns
  - A string representing the completed text.
  """
  @callback complete(String.t(), String.t()) :: String.t()
end
