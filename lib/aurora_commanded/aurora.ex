defmodule AuroraCommanded.Aurora do
  @moduledoc """
  The Aurora context.
  """

  import Ecto.Query, warn: false
  alias Aurora.Projection.Repo

  alias AuroraCommanded.Aurora.UO

  @doc """
  Returns the list of uo_table.

  ## Examples

      iex> list_uo_table()
      [%UO{}, ...]

  """
  def list_uo_table do
    Repo.all(UOProjection)
  end

  @doc """
  Gets a single uo.

  Raises `Ecto.NoResultsError` if the Uo does not exist.

  ## Examples

      iex> get_uo!(123)
      %UO{}

      iex> get_uo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_uo!(id), do: Repo.get!(UOProjection, id)

  @doc """
  Creates a uo.

  ## Examples

      iex> create_uo(%{field: value})
      {:ok, %UO{}}

      iex> create_uo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_uo(attrs \\ %{}) do
    %UO{}
    |> UO.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a uo.

  ## Examples

      iex> update_uo(uo, %{field: new_value})
      {:ok, %UO{}}

      iex> update_uo(uo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_uo(%UO{} = uo, attrs) do
    uo
    |> UO.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a uo.

  ## Examples

      iex> delete_uo(uo)
      {:ok, %UO{}}

      iex> delete_uo(uo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_uo(%UO{} = uo) do
    Repo.delete(uo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking uo changes.

  ## Examples

      iex> change_uo(uo)
      %Ecto.Changeset{data: %UO{}}

  """
  def change_uo(%UO{} = uo, attrs \\ %{}) do
    UO.changeset(uo, attrs)
  end
end
