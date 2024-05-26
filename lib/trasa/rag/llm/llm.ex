defmodule Trasa.Rag.LLM do
  @moduledoc """
  Provides an interface to an LLM completion service. This module is
  responsible for forwarding completion requests to the configured
  language model.
  """

  @doc """
  Completes a given prompt using the language model specified in the
  application's configuration.

  ## Parameters
  - `context`: The context in which the completion is requested.
  - `prompt`: The input string for which the completion is to be generated.

  ## Returns
  - The completed string as returned by the language model.
  """
  def complete(context, prompt) do
    context =
      "You are a helpful assistant. You will use the following context to answer any questions: #{context}"

    Application.get_env(:trasa, :llm).complete(context, prompt)
  end
end
