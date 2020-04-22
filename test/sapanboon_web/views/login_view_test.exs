defmodule SapanboonWeb.LoginViewTest do
  use SapanboonWeb.ConnCase, async: true
  alias SapanboonWeb.LoginView
  import Phoenix.View

  test "renders show.json" do
    expected = %{data: %{
      status: "successfully",
      email: "some email",
      name: "some name"
    }}
    login = %{login: %{
      status: "successfully",
      email: "some email",
      name: "some name"
    }}
    assert render(LoginView, "show.json", login) == expected
  end

  test "renders page.json" do
    expected = %{
      status: "successfully",
      email: "some email",
      name: "some name"
    }
    login = %{login: %{
      status: "successfully",
      email: "some email",
      name: "some name"
    }}
    assert render(LoginView, "page.json", login) == expected
  end

  test "renders page login" do
    assert render_to_string(LoginView, "index.html", []) =~ "เข้าสู่ระบบ"
    assert render_to_string(LoginView, "index.html", []) =~ "เข้าสู่ระบบด้วย Facebook"
    assert render_to_string(LoginView, "index.html", []) =~ "เข้าสู่ระบบด้วย Google"
  end

end