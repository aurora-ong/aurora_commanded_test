defmodule TaskCreated do
  @derive Jason.Encoder
  defstruct [:project_id, :task_id, :task_name]
end
