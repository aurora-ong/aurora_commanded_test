defmodule MyApp.ExampleProjector do
  use Commanded.Projections.Ecto,
    application: Aurora.CommandedApplication,
    repo: Aurora.Projection.Repo,
    name: "uo-projector-4"

  project(%UOCreated{} = event, metadata, fn multi ->
    %UOCreated{uo_id: uo_id, uo_name: uo_name} = event

    projection = %UOProjection{
      uo_id: uo_id,
      uo_name: uo_name,
      uo_status: :active,
      created_at: metadata.created_at,
      updated_at: metadata.created_at
    }

    IO.inspect("Proyectando..")
    IO.inspect(projection)

    Ecto.Multi.insert(multi, :uo_table, projection)
  end)

  @impl Commanded.Projections.Ecto
  def after_update(_event, _metadata, _changes) do
    Phoenix.PubSub.broadcast(AuroraCommanded.PubSub, "projector_update", :uo)
    :ok
  end
end
