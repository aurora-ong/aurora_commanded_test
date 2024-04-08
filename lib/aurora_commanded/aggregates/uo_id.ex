defmodule UOIdentity do
  defstruct [:uo_id]

  defimpl String.Chars do
    def to_string(%UOIdentity{uo_id: uo_id}),
      do: "aurora"
  end
end
