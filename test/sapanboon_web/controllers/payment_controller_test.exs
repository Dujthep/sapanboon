defmodule SapanboonWeb.PaymentControllerTest do
  use SapanboonWeb.ConnCase
  alias Sapanboon.SapanboonWeb

    describe "index" do
    test "update payment and get history", %{conn: conn} do
      conn = get(conn, Routes.payment_path(conn, :index, 58))
      item = conn.assigns.history

      assert item.name =~ "บสถและพระประธ"
    end
  end
end
