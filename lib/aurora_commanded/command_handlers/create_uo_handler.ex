defmodule CreateUOHandler do
  alias Aurora.CommandedApplication
  @behaviour Commanded.Commands.Handler

  def handle(%UO{uo_id: nil}, %CreateUO{} = command) do
    %CreateUO{uo_id: uo_id, uo_name: uo_name} = command

    case UOTree.get_parent!(uo_id) do
      :root ->
        %UOCreated{uo_id: uo_id, uo_name: uo_name}
      parent ->
        IO.inspect(parent, name: "Parent")
        IO.inspect(CommandedApplication.aggregate_state(UO, parent), name: "Parent")
        case CommandedApplication.aggregate_state(UO, parent) do
          %UO{uo_status: :active} ->
            %UOCreated{uo_id: uo_id, uo_name: uo_name}
            %UO{uo_id: nil} ->
              {:error, :uo_parent_not_exists}
            %UO{uo_status: _status} ->
              {:error, :uo_parent_not_active}
        end
    end

  end

  def handle(%UO{} = aggregate, %CreateUO{}) do
    IO.inspect(aggregate, label: "Agregate")
    {:error, :uo_already_exists}
  end
end
