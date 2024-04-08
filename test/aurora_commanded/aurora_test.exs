defmodule AuroraCommanded.AuroraTest do
  use AuroraCommanded.DataCase

  alias AuroraCommanded.Aurora

  describe "uo_table" do
    alias AuroraCommanded.Aurora.UO

    import AuroraCommanded.AuroraFixtures

    @invalid_attrs %{name: nil, users: nil, age: nil}

    test "list_uo_table/0 returns all uo_table" do
      uo = uo_fixture()
      assert Aurora.list_uo_table() == [uo]
    end

    test "get_uo!/1 returns the uo with given id" do
      uo = uo_fixture()
      assert Aurora.get_uo!(uo.id) == uo
    end

    test "create_uo/1 with valid data creates a uo" do
      valid_attrs = %{name: "some name", users: "some users", age: 42}

      assert {:ok, %UO{} = uo} = Aurora.create_uo(valid_attrs)
      assert uo.name == "some name"
      assert uo.users == "some users"
      assert uo.age == 42
    end

    test "create_uo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Aurora.create_uo(@invalid_attrs)
    end

    test "update_uo/2 with valid data updates the uo" do
      uo = uo_fixture()
      update_attrs = %{name: "some updated name", users: "some updated users", age: 43}

      assert {:ok, %UO{} = uo} = Aurora.update_uo(uo, update_attrs)
      assert uo.name == "some updated name"
      assert uo.users == "some updated users"
      assert uo.age == 43
    end

    test "update_uo/2 with invalid data returns error changeset" do
      uo = uo_fixture()
      assert {:error, %Ecto.Changeset{}} = Aurora.update_uo(uo, @invalid_attrs)
      assert uo == Aurora.get_uo!(uo.id)
    end

    test "delete_uo/1 deletes the uo" do
      uo = uo_fixture()
      assert {:ok, %UO{}} = Aurora.delete_uo(uo)
      assert_raise Ecto.NoResultsError, fn -> Aurora.get_uo!(uo.id) end
    end

    test "change_uo/1 returns a uo changeset" do
      uo = uo_fixture()
      assert %Ecto.Changeset{} = Aurora.change_uo(uo)
    end
  end
end
