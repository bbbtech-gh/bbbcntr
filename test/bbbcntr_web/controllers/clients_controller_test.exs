defmodule BbbcntrWeb.ClientsControllerTest do
  use BbbcntrWeb.ConnCase

  import Bbbcntr.AuthFixtures

  alias Bbbcntr.Auth.Clients

  @create_attrs %{
    domain: "some domain",
    email: "some email",
    detail: "some detail"
  }
  @update_attrs %{
    domain: "some updated domain",
    email: "some updated email",
    detail: "some updated detail"
  }
  @invalid_attrs %{domain: nil, email: nil, detail: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all clients", %{conn: conn} do
      conn = get(conn, ~p"/api/clients")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create clients" do
    test "renders clients when data is valid", %{conn: conn} do
      conn =
        post(
          conn,
          ~p"/api/clients",
          email: @create_attrs[:email],
          detail: @create_attrs[:detail],
          domain: @create_attrs[:domain]
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/clients/#{id}")

      assert %{
               "id" => ^id,
               "detail" => "some detail",
               "domain" => "some domain",
               "email" => "some email"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(
          conn,
          ~p"/api/clients",
          email: @invalid_attrs[:email],
          detail: @invalid_attrs[:detail],
          domain: @invalid_attrs[:domain]
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update clients" do
    setup [:create_clients]

    test "renders clients when data is valid", %{conn: conn, clients: %Clients{id: id} = clients} do
      conn = put(conn, ~p"/api/clients/#{clients}", clients: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/clients/#{id}")

      assert %{
               "id" => ^id,
               "detail" => "some updated detail",
               "domain" => "some updated domain",
               "email" => "some updated email"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, clients: clients} do
      conn = put(conn, ~p"/api/clients/#{clients}", clients: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete clients" do
    setup [:create_clients]

    test "deletes chosen clients", %{conn: conn, clients: clients} do
      conn = delete(conn, ~p"/api/clients/#{clients}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/clients/#{clients}")
      end
    end
  end

  defp create_clients(_) do
    clients = clients_fixture()
    %{clients: clients}
  end
end
