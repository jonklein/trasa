# Custom Postgres type adding the Pgvector extension.

Postgrex.Types.define(
  Trasa.PostgresTypes,
  [Pgvector.Extensions.Vector] ++ Ecto.Adapters.Postgres.extensions(),
  []
)
