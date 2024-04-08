defmodule Aurora.CommandedApplication do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Commanded.Application,
    otp_app: :aurora_commanded,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: Aurora.EventStore
    ]
    # pubsub: [
    #   phoenix_pubsub: [
    #     adapter: Phoenix.PubSub.PG2,
    #     pool_size: 1
    #   ]
    # ]

  router(AuroraCommanded.Router)
end
