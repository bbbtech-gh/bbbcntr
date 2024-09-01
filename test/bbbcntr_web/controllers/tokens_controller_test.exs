defmodule BbbcntrWeb.TokensControllerTest do
  use BbbcntrWeb.ConnCase

  import Bbbcntr.AuthFixtures

  alias Bbbcntr.Auth.Tokens

  @create_attrs %{
    token: "some token",
    client: "some client",
    email: "some email",
    scopes: %{}
  }
  @update_attrs %{
    token: "some updated token",
    client: "some updated client",
    email: "some updated email",
    scopes: %{}
  }
  @invalid_attrs %{token: nil, client: nil, email: nil, scopes: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tokens", %{conn: conn} do
      conn = get(conn, ~p"/api/tokens")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create tokens" do
    test "renders tokens when data is valid", %{conn: conn} do
      conn = post(
        conn, 
        ~p"/api/tokens", 
        email: @create_attrs[:email],
        client: @create_attrs[:client],
        scopes: @create_attrs[:scopes]
      )
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/tokens/#{id}")

      assert %{
               "id" => ^id,
               "client" => "some client",
               "email" => "some email",
               "scopes" => %{},
               "token" => "abcd"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(
        conn, 
        ~p"/api/tokens", 
        email: @invalid_attrs[:email],
        client: @invalid_attrs[:client],
        scopes: @invalid_attrs[:scopes]
      )
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tokens" do
    setup [:create_tokens]

    test "renders tokens when data is valid", %{conn: conn, tokens: %Tokens{id: id} = tokens} do
      conn = put(conn, ~p"/api/tokens/#{tokens}", tokens: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/tokens/#{id}")

      assert %{
               "id" => ^id,
               "client" => "some updated client",
               "email" => "some updated email",
               "scopes" => %{},
               "token" => "some updated token"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, tokens: tokens} do
      conn = put(conn, ~p"/api/tokens/#{tokens}", tokens: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tokens" do
    setup [:create_tokens]

    test "deletes chosen tokens", %{conn: conn, tokens: tokens} do
      conn = delete(conn, ~p"/api/tokens/#{tokens}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/tokens/#{tokens}")
      end
    end
  end

  defp create_tokens(_) do
    tokens = tokens_fixture()
    %{tokens: tokens}
  end
end
