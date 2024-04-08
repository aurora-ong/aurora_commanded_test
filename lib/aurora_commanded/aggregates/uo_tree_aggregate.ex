defmodule UOTreeAgreggate do
  defstruct [:uo_id, :uo_name, :uo_child]

  # Public command API

  def execute(%UOTreeAgreggate{uo_id: nil} = aggregate, %CreateUO2{uo_id: uo_id, uo_name: uo_name}) do
    IO.inspect(aggregate, label: "Agregate")

    if UOTree.is_root(uo_id) do
      %UOCreated{uo_id: uo_id, uo_name: uo_name}
    else
      {:error, "not root"}
    end
  end


  # Ensure account has not already been opened
  def execute(%UOTreeAgreggate{} = aggregate, %CreateUO2{}) do
    IO.inspect(aggregate, label: "Agregate")
    {:error, :account_already_opened}
  end

  # State mutators

  def apply(%UOTreeAgreggate{} = uo, %UOCreated{} = event) do
    IO.inspect(uo, label: "apply UOTREE")
    %UOCreated{uo_id: uo_id, uo_name: uo_name} = event

    %{
      uo_id: uo_id,
      uo_name: uo_name,
      uo_child: [
        %{
          uo_id: uo_id,
          uo_name: uo_name,
          uo_child: []
        }
      ]
    }
  end

end
