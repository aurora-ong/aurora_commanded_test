defmodule AuroraCommanded.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Aurora.CommandedApplication,
      # UOTreeHandler,
      # PersonListHandler,
      # MembershipHandler,

      Aurora.Projection.Repo,
      MyApp.ExampleProjector,
      # %{
      #   id: Phoenix.PubSub.PG2,
      #   start: {Phoenix.PubSub.PG2, :start_link, [:fridge, []]}
      # },

      # Start the Telemetry supervisor
      AuroraCommandedWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: AuroraCommanded.PubSub},
      # Start Finch
      {Finch, name: AuroraCommanded.Finch},
      # Start the Endpoint (http/https)
      AuroraCommandedWeb.Endpoint,
      # Start a worker by calling: AuroraCommanded.Worker.start_link(arg)
      # {AuroraCommanded.Worker, arg},

    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AuroraCommanded.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AuroraCommandedWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
