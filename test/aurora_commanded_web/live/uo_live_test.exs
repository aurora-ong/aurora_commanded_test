defmodule AuroraCommandedWeb.UOLiveTest do
  use AuroraCommandedWeb.ConnCase

  import Phoenix.LiveViewTest
  import AuroraCommanded.AuroraFixtures

  @create_attrs %{name: "some name", users: "some users", age: 42}
  @update_attrs %{name: "some updated name", users: "some updated users", age: 43}
  @invalid_attrs %{name: nil, users: nil, age: nil}

  defp create_uo(_) do
    uo = uo_fixture()
    %{uo: uo}
  end

  describe "Index" do
    setup [:create_uo]

    test "lists all uo_table", %{conn: conn, uo: uo} do
      {:ok, _index_live, html} = live(conn, ~p"/uo_table")

      assert html =~ "Listing Uo table"
      assert html =~ uo.name
    end

    test "saves new uo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/uo_table")

      assert index_live |> element("a", "New Uo") |> render_click() =~
               "New Uo"

      assert_patch(index_live, ~p"/uo_table/new")

      assert index_live
             |> form("#uo-form", uo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#uo-form", uo: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/uo_table")

      html = render(index_live)
      assert html =~ "Uo created successfully"
      assert html =~ "some name"
    end

    test "updates uo in listing", %{conn: conn, uo: uo} do
      {:ok, index_live, _html} = live(conn, ~p"/uo_table")

      assert index_live |> element("#uo_table-#{uo.id} a", "Edit") |> render_click() =~
               "Edit Uo"

      assert_patch(index_live, ~p"/uo_table/#{uo}/edit")

      assert index_live
             |> form("#uo-form", uo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#uo-form", uo: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/uo_table")

      html = render(index_live)
      assert html =~ "Uo updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes uo in listing", %{conn: conn, uo: uo} do
      {:ok, index_live, _html} = live(conn, ~p"/uo_table")

      assert index_live |> element("#uo_table-#{uo.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#uo_table-#{uo.id}")
    end
  end

  describe "Show" do
    setup [:create_uo]

    test "displays uo", %{conn: conn, uo: uo} do
      {:ok, _show_live, html} = live(conn, ~p"/uo_table/#{uo}")

      assert html =~ "Show Uo"
      assert html =~ uo.name
    end

    test "updates uo within modal", %{conn: conn, uo: uo} do
      {:ok, show_live, _html} = live(conn, ~p"/uo_table/#{uo}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Uo"

      assert_patch(show_live, ~p"/uo_table/#{uo}/show/edit")

      assert show_live
             |> form("#uo-form", uo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#uo-form", uo: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/uo_table/#{uo}")

      html = render(show_live)
      assert html =~ "Uo updated successfully"
      assert html =~ "some updated name"
    end
  end
end
