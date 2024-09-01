defmodule Bbbcntr.Auth.Tokens do
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
  def changeset(tokens, attrs) do
    tokens
    |> cast(attrs, [:email, :token, :scopes, :client])
    |> validate_required([:email, :token, :client])
  end
end
