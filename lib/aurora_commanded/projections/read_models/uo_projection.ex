defmodule UOProjection do
  use Ecto.Schema

  @primary_key {:uo_id, :string, autogenerate: false}
  schema "uo_table" do
    field :uo_name, :string
    field :uo_status, Ecto.Enum, values: [:active]
    field :created_at, :utc_datetime_usec
    field :updated_at, :utc_datetime_usec
  end
end
