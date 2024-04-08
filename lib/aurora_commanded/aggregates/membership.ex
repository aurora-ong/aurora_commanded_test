defmodule Membership do
  defstruct [:membership_id, :person_id, :uo_id, :membership_status]

  # Public command API

  def execute(%Membership{person_id: nil, uo_id: nil} = aggregate, %StartMembership{person_id: person_id, uo_id: uo_id}) do
    %StartMembership{person_id: person_id, uo_id: uo_id}
  end

  # Ensure account has not already been opened
  def execute(%Membership{} = aggregate, %StartMembership{}) do
    {:error, :membership_already_created}
  end

  # State mutators

  def apply(%Membership{} = uo, %StartMembership{} = event) do
    %StartMembership{person_id: person_id, uo_id: uo_id} = event

    %Membership{
      uo_id: uo_id,
      person_id: person_id,
      membership_status: :junior
    }
  end

  def apply(%Membership{} = membership, %RegisterPerson{} = event) do
    IO.inspect(event, name: "QQMembership")
    membership
  end
end
