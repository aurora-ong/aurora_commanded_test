defmodule UO do
  defstruct [:uo_id, :uo_status, :uo_membership, :uo_power]

  # State mutators

  def apply(%UO{} = uo, %UOCreated{} = event) do
    IO.inspect(uo, label: "apply")
    %UOCreated{uo_id: uo_id} = event

    %UO{
      uo_id: uo_id,
      uo_status: :active,
      uo_membership: %{}
    }
  end

  def apply(%UO{} = uo, %MembershipStarted{} = event) do
    IO.inspect(uo, label: "apply")
    %MembershipStarted{person_id: person_id} = event
    %UO{ uo |
      uo_membership: Map.put(uo.uo_membership, person_id, :junior)
    }
  end

  def has_active_membership?(%UO{uo_membership: uo_membership}, person_id) do
    Map.has_key?(uo_membership, person_id)
  end

  def get_active_membership!(%UO{uo_membership: uo_membership}, person_id) do
    case Map.get(uo_membership, person_id) do
      nil -> {:error, :membership_not_active}
      membership -> membership
    end
  end
end
