defmodule MembershipStarted do
  @derive Jason.Encoder
  defstruct [:membership_id, :uo_id, :person_id]
end
