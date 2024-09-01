defmodule BbbcntrWeb.TokensJSON do
  alias Bbbcntr.Auth.Tokens

  @doc """
  Renders a list of tokens.
  """
  def index(%{tokens: tokens}) do
    %{data: for(tokens <- tokens, do: data(tokens))}
  end

  @doc """
  Renders a single tokens.
  """
  def show(%{tokens: tokens}) do
    %{data: data(tokens)}
  end

  defp data(%Tokens{} = tokens) do
    %{
      id: tokens.id,
      email: tokens.email,
      token: tokens.token,
      scopes: tokens.scopes,
      client: tokens.client
    }
  end
end
