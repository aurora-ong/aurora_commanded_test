defmodule MembershipHandler do
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

  def handle(%MembershipStarted{uo_id: uo_id, membership_id: membership_id, person_id: person_id}, _metadata) do
    IO.inspect("Manejando evento..")

    member = %{
      uo_id: uo_id,
      person_id: person_id,
      membership_id: membership_id,
      membership_status: :active,
      membership_role: :junior
    }

    Agent.update(__MODULE__, fn t -> t ++ [member] end)
  end

  def membership_list do
    Agent.get(__MODULE__, fn t -> t end)
  end

  def error(a, b, c) do
    IO.inspect("Error..")
  end
end
