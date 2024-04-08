defmodule AuroraCommandedWeb.ErrorJSONTest do
  use AuroraCommandedWeb.ConnCase, async: true

  test "renders 404" do
    assert AuroraCommandedWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert AuroraCommandedWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
