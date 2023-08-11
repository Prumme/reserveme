defmodule Reserveme.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ReservemeWeb.Telemetry,
      # Start the Ecto repository
      Reserveme.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Reserveme.PubSub},
      # Start Finch
      {Finch, name: Reserveme.Finch},
      # Start the Endpoint (http/https)
      ReservemeWeb.Endpoint
      # Start a worker by calling: Reserveme.Worker.start_link(arg)
      # {Reserveme.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Reserveme.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ReservemeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
