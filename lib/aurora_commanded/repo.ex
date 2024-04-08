defmodule Aurora.Projection.Repo do
  use Ecto.Repo,
    otp_app: :aurora_commanded,
    adapter: Ecto.Adapters.Postgres
end
