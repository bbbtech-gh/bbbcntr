defmodule Bbbcntr.Auth.Clients do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "clients" do
    field :domain, :string
    field :email, :string
    field :detail, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(clients, attrs) do
    clients
    |> cast(attrs, [:email, :domain, :detail])
    |> validate_required([:email, :domain, :detail])
  end
end
