defmodule BbbcntrWeb.ClientsController do
  use BbbcntrWeb, :controller

  alias Bbbcntr.Auth
  alias Bbbcntr.Auth.Clients

  action_fallback BbbcntrWeb.FallbackController

  def index(conn, _params) do
    clients = Auth.list_clients()
    render(conn, :index, clients: clients)
  end

  def create(conn, %{"email" => email, "detail"=>detail, "domain"=>domain}) do
    with {:ok, %Clients{} = clients} <- Auth.create_clients(%{"email" => email, "detail"=>detail, "domain"=>domain}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clients/#{clients}")
      |> render(:show, clients: clients)
    end
  end

  def show(conn, %{"id" => id}) do
    clients = Auth.get_clients!(id)
    render(conn, :show, clients: clients)
  end

  def update(conn, %{"id" => id, "clients" => clients_params}) do
    clients = Auth.get_clients!(id)

    with {:ok, %Clients{} = clients} <- Auth.update_clients(clients, clients_params) do
      render(conn, :show, clients: clients)
    end
  end

  def delete(conn, %{"id" => id}) do
    clients = Auth.get_clients!(id)

    with {:ok, %Clients{}} <- Auth.delete_clients(clients) do
      send_resp(conn, :no_content, "")
    end
  end
end
