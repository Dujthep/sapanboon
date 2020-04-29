defmodule SapanboonWeb.SuccessControllerTest do
  use SapanboonWeb.ConnCase

  describe "index" do
    test "get success page, should response status 200", %{conn: conn} do
      user = %Sapanboon.User{email: "mock email"}
      conn = conn
            |> assign(:user, user)
            |> get(Routes.success_path(conn, :index, "5d3722884f17ac0001c74e80"))

      assert html_response(conn, 200) =~ "ขอบคุณสำหรับการบริจาค"
      assert html_response(conn, 200) =~ "โครงการปล่อยปลาดุกหน้าเขียง วันที่ 1 มีนาคม 2563"
    end
  end

end
