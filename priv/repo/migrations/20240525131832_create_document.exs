defmodule Trasa.Repo.Migrations.CreateDocument do
  use Ecto.Migration

  def change do
    create table(:documents, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :text, :text, null: false
      timestamps()
    end

    create table(:embeddings, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :vector, :"vector(384)", null: false
      add :text, :text, null: false
      add :document_id, :uuid, null: false
      timestamps()
    end
  end
end
