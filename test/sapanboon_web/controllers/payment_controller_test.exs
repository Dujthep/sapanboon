defmodule SapanboonWeb.PaymentControllerTest do
  use SapanboonWeb.ConnCase

  describe "index" do
    test "update payment and get history", %{conn: conn} do
      conn = get(conn, Routes.payment_path(conn, :index, 50))
      assert html_response(conn, 200) =~ "กรุณาแสกน QR เพื่อบริจาค"
      assert html_response(conn, 200) =~ "โครงการปล่อยปลาดุกหน้าเขียง วันที่ 1 มีนาคม 2563"
    end
  end

end
