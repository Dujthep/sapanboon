defmodule SapanboonWeb.ContactControllerTest do
  use SapanboonWeb.ConnCase

  describe "index" do
    test "Check wording 'ติดต่อสะพานบุญ' on contact pages.", %{conn: conn} do
      conn = get(conn, Routes.contact_path(conn, :index))
      assert html_response(conn, 200) =~ "ติดต่อสะพานบุญ"
    end

    test "Check wording text cover on contact pages.", %{conn: conn} do
      conn = get(conn, Routes.contact_path(conn, :index))
      assert html_response(conn, 200) =~ "สะพานบุญ ชวนทำทาน คือการให้ ท่านว่าไว้ สวยงาม สามสถาน หนึ่งให้ของ สองได้ธรรม สามเบิกบาน ให้สุขสันต์ เกื้อกูล สุขนิรันดร์"
    end

    test "Check wording address on contact pages.", %{conn: conn} do
      conn = get(conn, Routes.contact_path(conn, :index))
      assert html_response(conn, 200) =~ "มูลนิธิสะพานบุญ 542 ถนนเพชรเกษม เขตหนองแขม กทม. 10160"
    end

    test "Check wording phone number on contact pages.", %{conn: conn} do
      conn = get(conn, Routes.contact_path(conn, :index))
      assert html_response(conn, 200) =~ "02-807-4500 ต่อ 115, 081-651-1718"
    end

    test "Check wording email on contact pages.", %{conn: conn} do
      conn = get(conn, Routes.contact_path(conn, :index))
      assert html_response(conn, 200) != ""
    end
  end

end
