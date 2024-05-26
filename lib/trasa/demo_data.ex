defmodule Trasa.DemoData do
  @moduledoc """
  Provides functionality to load demo data into the database.
  """

  @doc """
  Loads demo data from files located in the `demo_data` directory and
  inserts them into the database as Trasa.Rag.Document.
  """

  def load() do
    Trasa.Repo.delete_all(Trasa.Rag.Document)

    File.ls!("demo_data")
    |> Enum.map(&File.read!("demo_data/#{&1}"))
    |> Enum.map(fn contents ->
      {:ok, doc} = Trasa.Rag.create_document(%{text: contents})
      doc
    end)
  end
end
