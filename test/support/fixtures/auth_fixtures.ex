defmodule Bbbcntr.AuthFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bbbcntr.Auth` context.
  """

  @doc """
  Generate a tokens.
  """
  def tokens_fixture(attrs \\ %{}) do
    {:ok, tokens} =
      attrs
      |> Enum.into(%{
        client: "some client",
        email: "some email",
        scopes: %{},
        token: "some token"
      })
      |> Bbbcntr.Auth.create_tokens()

    tokens
  end

  @doc """
  Generate a clients.
  """
  def clients_fixture(attrs \\ %{}) do
    {:ok, clients} =
      attrs
      |> Enum.into(%{
        detail: "some detail",
        domain: "some domain",
        email: "some email"
      })
      |> Bbbcntr.Auth.create_clients()

    clients
  end
end
