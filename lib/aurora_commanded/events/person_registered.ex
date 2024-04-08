defmodule PersonRegistered do
  @derive Jason.Encoder
  defstruct [:person_id, :person_name]
end
