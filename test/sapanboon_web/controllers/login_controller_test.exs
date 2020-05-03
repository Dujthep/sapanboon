defmodule SapanboonWeb.LoginControllerTest do
  use SapanboonWeb.ConnCase

  @ueberauth_auth %{
    credentials: %{
      token:
        "ya29.a0Ae4lvC20zHWWIqNGbmxupJTWRuEh5m7lOwgRS1OeXnn24cr7Y8YFuzWQF8FZgYe_abHEGJVlFXsqcFhklqUMyHiUoQl18sxTD9-ViYqYxG05chodqgwakTJR9WbfV5o6dywh59AkdsocdRb29ZL8kRhdk_lT7gS6sF4"
    },
    info: %{
      email: "sapanboon.dev@gmail.com",
      first_name: "sothon",
      last_name: "sitsiwalai",
      name: "sothon sitsiwalai"
    },
    provider: :google,
    uid: "106742807771285561141"
  }

  test "index page login", %{conn: conn} do
    conn = get(conn, Routes.login_path(conn, :index))
    assert html_response(conn, 200) =~ "เข้าสู่ระบบ"
    assert html_response(conn, 200) =~ "เข้าสู่ระบบด้วย Facebook"
    assert html_response(conn, 200) =~ "เข้าสู่ระบบด้วย Google"
  end

  describe "authen user login" do
    test "first login user", %{conn: conn} do
      new_user = %{
        credentials: %{
          token:
            "token"
        },
        info: %{
          email: "new@email.com",
          first_name: "new first_name",
          last_name: "new last_name",
          name: "new user"
        },
        provider: :google,
        uid: "12345"
      }
      conn = conn
        |> assign(:ueberauth_auth, new_user)
        |> get("/auth/google/callback")
      assert redirected_to(conn) == Routes.projects_path(conn, :index)
    end

    test "wellcome back user", %{conn: conn} do
      conn = conn
        |> assign(:ueberauth_auth, @ueberauth_auth)
        |> get("/auth/google/callback")
      assert redirected_to(conn) == Routes.projects_path(conn, :index)
    end
  end

  test "signout", %{conn: conn} do
    conn = conn
      |> assign(:ueberauth_auth, @ueberauth_auth)
      |> get(Routes.login_path(conn, :delete))
    assert redirected_to(conn, 302)
  end

  test "create login gives a status 200", %{conn: conn} do
    params = %{email: "some email", provider: "some provider", uid: "some uid", name: "some name", role: "some role"}
    actual = post(conn, Routes.login_path(conn, :create, params))
          |> json_response(200)

    expected = %{"data" => %{"status" => "successfully", "email" => "some email", "name" => "some name"}}

    assert actual == expected
  end

  test "redirect page admin", %{conn: conn} do
    user = %Sapanboon.User{uid: "1234"}
    conn = conn
      |> assign(:user, user)
      |> get(Routes.login_path(conn, :admin))
      assert redirected_to(conn) == "http://localhost:4200/sapanboon/?uid=1234"
  end

end
