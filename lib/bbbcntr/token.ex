defmodule Bbbcntr.Token do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tokens" do
    field :token, :string
    field :client, :string
    field :email, :string
    field :scopes, :map

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(token, attrs) do
    token
    |> cast(attrs, [:email, :scopes, :client])
    |> validate_required([:email, :client, :scopes])
  end
end
