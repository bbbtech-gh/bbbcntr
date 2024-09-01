defmodule BbbcntrWeb.ClientsJSON do
  alias Bbbcntr.Auth.Clients

  @doc """
  Renders a list of clients.
  """
  def index(%{clients: clients}) do
    %{data: for(clients <- clients, do: data(clients))}
  end

  @doc """
  Renders a single clients.
  """
  def show(%{clients: clients}) do
    %{data: data(clients)}
  end

  defp data(%Clients{} = clients) do
    %{
      id: clients.id,
      email: clients.email,
      domain: clients.domain,
      detail: clients.detail
    }
  end
end
