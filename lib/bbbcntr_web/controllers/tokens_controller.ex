defmodule BbbcntrWeb.TokensController do
  use BbbcntrWeb, :controller

  alias Bbbcntr.Auth
  alias Bbbcntr.Auth.Tokens

  action_fallback BbbcntrWeb.FallbackController

  def index(conn, _params) do
    tokens = Auth.list_tokens()
    render(conn, :index, tokens: tokens)
  end

  def create(conn, %{
      "email" => email,
      "scopes" => scope,
      "client" => client
  }) do
    token = "abcd"
    with {:ok, %Tokens{} = tokens} <- Auth.create_tokens(%{
        "email" => email,
        "scopes" => scope,
        "client" => client,
        "token" => token
    }) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/tokens/#{tokens}")
      |> render(:show, tokens: tokens)
    end
  end

  def show(conn, %{"id" => id}) do
    tokens = Auth.get_tokens!(id)
    render(conn, :show, tokens: tokens)
  end

  def update(conn, %{"id" => id, "tokens" => tokens_params}) do
    tokens = Auth.get_tokens!(id)

    with {:ok, %Tokens{} = tokens} <- Auth.update_tokens(tokens, tokens_params) do
      render(conn, :show, tokens: tokens)
    end
  end

  def delete(conn, %{"id" => id}) do
    tokens = Auth.get_tokens!(id)

    with {:ok, %Tokens{}} <- Auth.delete_tokens(tokens) do
      send_resp(conn, :no_content, "")
    end
  end
end
