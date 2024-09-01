defmodule Bbbcntr.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BbbcntrWeb.Telemetry,
      Bbbcntr.Repo,
      {DNSCluster, query: Application.get_env(:bbbcntr, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Bbbcntr.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Bbbcntr.Finch},
      # Start a worker by calling: Bbbcntr.Worker.start_link(arg)
      # {Bbbcntr.Worker, arg},
      # Start to serve requests, typically the last entry
      BbbcntrWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bbbcntr.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BbbcntrWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
