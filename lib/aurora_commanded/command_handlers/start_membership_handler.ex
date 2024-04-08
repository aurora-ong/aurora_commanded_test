defmodule StartMembershipHandler do
  alias EventStore.UUID
  alias Aurora.CommandedApplication
  @behaviour Commanded.Commands.Handler

  def handle(%UO{uo_id: nil}, %StartMembership{}) do
    {:error, :uo_not_exists}
  end

  def handle(%UO{uo_id: uo_id, uo_status: :active} = aggregate, %StartMembership{
        uo_id: uo_id,
        person_id: person_id
      }) do
    case UO.has_active_membership?(aggregate, person_id) do
      false ->
        case UOTree.get_parent!(uo_id) do
          :root ->
            %MembershipStarted{uo_id: uo_id, person_id: person_id, membership_id: UUID.uuid4()}

          parent ->
            IO.inspect(parent, name: "Parent")
            IO.inspect(CommandedApplication.aggregate_state(UO, parent), name: "Parent")

            case CommandedApplication.aggregate_state(UO, parent) do
              %UO{uo_status: :active} = parent_uo ->
                case UO.has_active_membership?(parent_uo, person_id) do
                  false ->
                    {:error, :not_in_parent}

                  true ->
                    %MembershipStarted{
                      uo_id: uo_id,
                      person_id: person_id,
                      membership_id: UUID.uuid4()
                    }
                end

              %UO{uo_id: nil} ->
                {:error, :uo_parent_not_exists}

              %UO{uo_status: _status} ->
                {:error, :uo_parent_not_active}
            end
        end

      true ->
        {:error, :has_active_membership}
    end
  end
end
