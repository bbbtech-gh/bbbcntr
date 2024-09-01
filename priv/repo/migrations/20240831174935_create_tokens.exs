defmodule Bbbcntr.Repo.Migrations.CreateTokens do
  use Ecto.Migration

  def change do
    create table(:tokens) do
      add :email, :string
      add :token, :string
      add :scopes, :map
      add :client, :string

      timestamps(type: :utc_datetime)
    end
  end
end
