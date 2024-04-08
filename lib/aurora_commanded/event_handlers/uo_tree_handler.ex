defmodule UOTreeHandler do
  use Commanded.Event.Handler,
    application: Aurora.CommandedApplication,
    name: __MODULE__,
    consistency: :strong,
    start_from: :origin

  def init do
    with {:ok, _pid} <- Agent.start_link(fn -> [] end, name: __MODULE__) do
      :ok
    end
  end

  def handle(%Elixir.UOCreated{uo_id: uo_id}, _metadata) do
    IO.inspect("Manejando evento..")
    Agent.update(__MODULE__, fn t -> t ++ [uo_id] end)
  end

  def current_tree do
    Agent.get(__MODULE__, fn t -> t end)
  end

  def error(a, b, c) do
    IO.inspect("Error..")
  end
end
