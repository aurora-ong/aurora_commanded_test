defmodule PersonListHandler do
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

  def handle(%PersonRegistered{person_id: person_id, person_name: person_name}, _metadata) do
    Agent.update(__MODULE__, fn t -> t ++ [%PersonRegistered{person_id: person_id, person_name: person_name}] end)
  end

  def person_list do
    Agent.get(__MODULE__, fn t -> t end)
  end

end
