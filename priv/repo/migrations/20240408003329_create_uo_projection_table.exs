defmodule NEOS.Repo.Migrations.CreateNeosPanoramaOrganizations do
  use Ecto.Migration

  def change do
    create table(:uo_table, primary_key: false) do
      add :uo_id, :string, primary_key: true
      add :uo_name, :string
      add :uo_status, :string
      add :created_at, :utc_datetime_usec
      add :updated_at, :utc_datetime_usec
    end

    create index(:uo_table, [:uo_id])
  end
end
