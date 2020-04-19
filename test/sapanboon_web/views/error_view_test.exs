defmodule SapanboonWeb.ErrorViewTest do
  use SapanboonWeb.ConnCase, async: true
  alias SapanboonWeb.ErrorView
  import Phoenix.View

  test "renders 500.html" do
    errpr_page = render_to_string(ErrorView, "500.html", [])
    assert errpr_page =~ "ไม่พบหน้าที่คุณต้องการ (404)"
    assert errpr_page =~ "คุณพระ!"
  end

  test "renders 404.html" do
    errpr_page = render_to_string(ErrorView, "404.html", [])
    assert errpr_page =~ "ไม่พบหน้าที่คุณต้องการ (404)"
    assert errpr_page =~ "คุณพระ!"
  end

  test "renders 404.json" do
    expected = %{errors: %{message: "Page not found"}}
    assert render(ErrorView, "404.json", []) == expected
  end

  test "renders 422.json" do
    expected = %{errors: %{message: "Bad request", errors: %{view_module: SapanboonWeb.ErrorView, view_template: "422.json"}}}
    assert render(ErrorView, "422.json", []) == expected
  end

  test "renders 500.json" do
    expected = %{errors: %{message: "Internal server error"}}
    assert render(ErrorView, "500.json", []) == expected
  end


end
