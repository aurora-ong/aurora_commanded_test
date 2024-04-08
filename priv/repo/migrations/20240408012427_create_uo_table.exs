defmodule AuroraCommanded.Repo.Migrations.CreateUoTable do
  use Ecto.Migration

  def change do
    create table(:uo_table) do
      add :users, :string
      add :name, :string
      add :age, :integer

      timestamps()
    end
  end
end
