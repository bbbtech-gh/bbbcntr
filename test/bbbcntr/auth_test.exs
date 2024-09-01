defmodule Bbbcntr.AuthTest do
  use Bbbcntr.DataCase

  alias Bbbcntr.Auth

  describe "tokens" do
    alias Bbbcntr.Auth.Tokens

    import Bbbcntr.AuthFixtures

    @invalid_attrs %{token: nil, client: nil, email: nil, scopes: nil}

    test "list_tokens/0 returns all tokens" do
      tokens = tokens_fixture()
      assert Auth.list_tokens() == [tokens]
    end

    test "get_tokens!/1 returns the tokens with given id" do
      tokens = tokens_fixture()
      assert Auth.get_tokens!(tokens.id) == tokens
    end

    test "create_tokens/1 with valid data creates a tokens" do
      valid_attrs = %{
        token: "some token",
        client: "some client",
        email: "some email",
        scopes: %{}
      }

      assert {:ok, %Tokens{} = tokens} = Auth.create_tokens(valid_attrs)
      assert tokens.token == "some token"
      assert tokens.client == "some client"
      assert tokens.email == "some email"
      assert tokens.scopes == %{}
    end

    test "create_tokens/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_tokens(@invalid_attrs)
    end

    test "update_tokens/2 with valid data updates the tokens" do
      tokens = tokens_fixture()

      update_attrs = %{
        token: "some updated token",
        client: "some updated client",
        email: "some updated email",
        scopes: %{}
      }

      assert {:ok, %Tokens{} = tokens} = Auth.update_tokens(tokens, update_attrs)
      assert tokens.token == "some updated token"
      assert tokens.client == "some updated client"
      assert tokens.email == "some updated email"
      assert tokens.scopes == %{}
    end

    test "update_tokens/2 with invalid data returns error changeset" do
      tokens = tokens_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_tokens(tokens, @invalid_attrs)
      assert tokens == Auth.get_tokens!(tokens.id)
    end

    test "delete_tokens/1 deletes the tokens" do
      tokens = tokens_fixture()
      assert {:ok, %Tokens{}} = Auth.delete_tokens(tokens)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_tokens!(tokens.id) end
    end

    test "change_tokens/1 returns a tokens changeset" do
      tokens = tokens_fixture()
      assert %Ecto.Changeset{} = Auth.change_tokens(tokens)
    end
  end

  describe "clients" do
    alias Bbbcntr.Auth.Clients

    import Bbbcntr.AuthFixtures

    @invalid_attrs %{domain: nil, email: nil, detail: nil}

    test "list_clients/0 returns all clients" do
      clients = clients_fixture()
      assert Auth.list_clients() == [clients]
    end

    test "get_clients!/1 returns the clients with given id" do
      clients = clients_fixture()
      assert Auth.get_clients!(clients.id) == clients
    end

    test "create_clients/1 with valid data creates a clients" do
      valid_attrs = %{domain: "some domain", email: "some email", detail: "some detail"}

      assert {:ok, %Clients{} = clients} = Auth.create_clients(valid_attrs)
      assert clients.domain == "some domain"
      assert clients.email == "some email"
      assert clients.detail == "some detail"
    end

    test "create_clients/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_clients(@invalid_attrs)
    end

    test "update_clients/2 with valid data updates the clients" do
      clients = clients_fixture()

      update_attrs = %{
        domain: "some updated domain",
        email: "some updated email",
        detail: "some updated detail"
      }

      assert {:ok, %Clients{} = clients} = Auth.update_clients(clients, update_attrs)
      assert clients.domain == "some updated domain"
      assert clients.email == "some updated email"
      assert clients.detail == "some updated detail"
    end

    test "update_clients/2 with invalid data returns error changeset" do
      clients = clients_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_clients(clients, @invalid_attrs)
      assert clients == Auth.get_clients!(clients.id)
    end

    test "delete_clients/1 deletes the clients" do
      clients = clients_fixture()
      assert {:ok, %Clients{}} = Auth.delete_clients(clients)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_clients!(clients.id) end
    end

    test "change_clients/1 returns a clients changeset" do
      clients = clients_fixture()
      assert %Ecto.Changeset{} = Auth.change_clients(clients)
    end
  end
end
