defmodule MockLLM do
  # For testing purposes, we don't need to use a real LLM - we
  # can just ensure that the LLM is invoked with the context
  # containing the data we expect.
  @behaviour Trasa.Rag.LLMProvider

  def complete(context, _prompt) do
    context
  end
end

defmodule TrasaTest do
  use ExUnit.Case
  doctest Trasa

  setup do
    Ecto.Adapters.SQL.Sandbox.checkout(Trasa.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Trasa.Repo, {:shared, self()})
    Application.put_env(:trasa, :llm, MockLLM)
    %{context: Trasa.Rag.Context.new()}
  end

  test "loads demo data" do
    Trasa.DemoData.load()
    assert Trasa.Repo.all(Trasa.Rag.Document) |> Enum.count() > 0
  end

  test "indexes demo data", %{context: context} do
    Trasa.DemoData.load()
    Trasa.Rag.Indexing.index_all(context)
    assert Trasa.Repo.all(Trasa.Rag.Embedding) |> Enum.count() > 0
  end

  test "responds to queries", %{context: context} do
    Trasa.DemoData.load()
    Trasa.Rag.Indexing.index_all(context)
    response = Trasa.Rag.query(context, "who did the boy meet in the forest?")
    assert response =~ "Onni"
    assert response =~ "Väinö"
    assert response =~ "Lumi"
  end
end
