defmodule SapanboonWeb.LoginControllerTest do
  use SapanboonWeb.ConnCase
  alias Sapanboon.SapanboonWeb

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

  test "creates user from Google information", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth_auth)
      |> get("/auth/google/callback")

    assert html_response(conn, 302) =~ "You are being"
  end

  test "signout", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth_auth)
      |> get(Routes.login_path(conn, :delete))

      IO.inspect(conn)
    assert redirected_to(conn, 302)
  end
end
