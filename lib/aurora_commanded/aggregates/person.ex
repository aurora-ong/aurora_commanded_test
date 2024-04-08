defmodule Person do
  defstruct [:person_id, :person_name]

  # Public command API

  def execute(%Person{person_id: nil} = aggregate, %RegisterPerson{person_id: person_id, person_name: person_name}) do
    %PersonRegistered{person_id: person_id, person_name: person_name}
  end

  # Ensure account has not already been opened
  def execute(%Person{} = aggregate, %RegisterPerson{}) do
    {:error, :person_already_registered}
  end

  # State mutators

  def apply(%Person{} = uo, %PersonRegistered{} = event) do
    %PersonRegistered{person_id: person_id, person_name: person_name} = event

    %Person{
      person_id: person_id,
      person_name: person_name
    }
  end

  def apply(%Person{} = person, %CreateUO2{} = event) do
    IO.inspect(event, name: "QQ")
    person
  end
end
