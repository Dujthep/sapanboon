defmodule SapanboonWeb.AboutControllerTest do
  use SapanboonWeb.ConnCase

  describe "index" do
    test "Check wording 'เกี่ยวกับเรา' on about pages.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "เกี่ยวกับเรา"
    end

    test "Check wording '1. โครงการที่ทำจริง' on about pages.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "1. โครงการที่ทำจริง"
    end

    test "Check wording '2. มีความโปร่งใส' on about pages.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "2. มีความโปร่งใส"
    end

    test "Check wording '3. ตรวจสอบได้' on about pages.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "3. ตรวจสอบได้"
    end

    test "Check wording '4. จัดโอนส่งโดยตรงให้กับเจ้าของโครงการ' on about pages.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "4. จัดโอนส่งโดยตรงให้กับเจ้าของโครงการ"
    end
  end

end
