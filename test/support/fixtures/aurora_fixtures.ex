defmodule AuroraCommanded.AuroraFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AuroraCommanded.Aurora` context.
  """

  @doc """
  Generate a uo.
  """
  def uo_fixture(attrs \\ %{}) do
    {:ok, uo} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name",
        users: "some users"
      })
      |> AuroraCommanded.Aurora.create_uo()

    uo
  end
end
