defmodule Bbbcntr.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :email, :string
      add :domain, :string
      add :detail, :string

      timestamps(type: :utc_datetime)
    end
  end
end
