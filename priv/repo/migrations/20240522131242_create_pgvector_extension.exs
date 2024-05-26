defmodule Trasa.Repo.Migrations.CreatePgvectorExtension do
  use Ecto.Migration

  def up do
    execute("CREATE EXTENSION vector")
  end

  def down do
    execute("DROP EXTENSION vector")
  end
end
