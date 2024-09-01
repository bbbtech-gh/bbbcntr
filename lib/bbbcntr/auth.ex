defmodule Bbbcntr.Auth do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  alias Bbbcntr.Repo

  alias Bbbcntr.Auth.Tokens

  @doc """
  Returns the list of tokens.

  ## Examples

      iex> list_tokens()
      [%Tokens{}, ...]

  """
  def list_tokens do
    Repo.all(Tokens)
  end

  @doc """
  Gets a single tokens.

  Raises `Ecto.NoResultsError` if the Tokens does not exist.

  ## Examples

      iex> get_tokens!(123)
      %Tokens{}

      iex> get_tokens!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tokens!(id), do: Repo.get!(Tokens, id)

  @doc """
  Creates a tokens.

  ## Examples

      iex> create_tokens(%{field: value})
      {:ok, %Tokens{}}

      iex> create_tokens(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tokens(attrs \\ %{}) do
    %Tokens{}
    |> Tokens.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tokens.

  ## Examples

      iex> update_tokens(tokens, %{field: new_value})
      {:ok, %Tokens{}}

      iex> update_tokens(tokens, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tokens(%Tokens{} = tokens, attrs) do
    tokens
    |> Tokens.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tokens.

  ## Examples

      iex> delete_tokens(tokens)
      {:ok, %Tokens{}}

      iex> delete_tokens(tokens)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tokens(%Tokens{} = tokens) do
    Repo.delete(tokens)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tokens changes.

  ## Examples

      iex> change_tokens(tokens)
      %Ecto.Changeset{data: %Tokens{}}

  """
  def change_tokens(%Tokens{} = tokens, attrs \\ %{}) do
    Tokens.changeset(tokens, attrs)
  end

  alias Bbbcntr.Auth.Clients

  @doc """
  Returns the list of clients.

  ## Examples

      iex> list_clients()
      [%Clients{}, ...]

  """
  def list_clients do
    Repo.all(Clients)
  end

  @doc """
  Gets a single clients.

  Raises `Ecto.NoResultsError` if the Clients does not exist.

  ## Examples

      iex> get_clients!(123)
      %Clients{}

      iex> get_clients!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clients!(id), do: Repo.get!(Clients, id)

  @doc """
  Creates a clients.

  ## Examples

      iex> create_clients(%{field: value})
      {:ok, %Clients{}}

      iex> create_clients(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clients(attrs \\ %{}) do
    %Clients{}
    |> Clients.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clients.

  ## Examples

      iex> update_clients(clients, %{field: new_value})
      {:ok, %Clients{}}

      iex> update_clients(clients, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clients(%Clients{} = clients, attrs) do
    clients
    |> Clients.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clients.

  ## Examples

      iex> delete_clients(clients)
      {:ok, %Clients{}}

      iex> delete_clients(clients)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clients(%Clients{} = clients) do
    Repo.delete(clients)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clients changes.

  ## Examples

      iex> change_clients(clients)
      %Ecto.Changeset{data: %Clients{}}

  """
  def change_clients(%Clients{} = clients, attrs \\ %{}) do
    Clients.changeset(clients, attrs)
  end
end
