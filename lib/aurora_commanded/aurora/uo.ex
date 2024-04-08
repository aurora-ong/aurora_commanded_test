defmodule AuroraCommanded.Aurora.UO do
  use Ecto.Schema
  import Ecto.Changeset

  schema "uo_table" do
    field :name, :string
    field :users, :string
    field :age, :integer

    timestamps()
  end

  @doc false
  def changeset(uo, attrs) do
    uo
    |> cast(attrs, [:users, :name, :age])
    |> validate_required([:users, :name, :age])
  end
end
