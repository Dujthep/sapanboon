defmodule SapanboonWeb.HistoryControllerTest do
  use SapanboonWeb.ConnCase

  alias Sapanboon.Histories

  @create_attrs %{id: 1, projectId: "some projectId", code: 1, name: "some name", email: "some email", transId: "some transId", transactionDate: "2010-04-17T14:00:00Z", transactionNo: 1, amount: 1000, status: "some status", imgSlip: "some imgSlip", paymentType: "some paymentType", fullName: "some fullName"}
  # @update_attrs %{id: 1, projectId: "some projectId", code: 1, name: "some name", email: "some email", transId: "some transId", transactionDate: "2010-04-17T14:00:00Z", transactionNo: 1, amount: 1000, status: "some status", imgSlip: "some imgSlip", paymentType: "some paymentType", fullName: "some fullName"}
  @invalid_attrs %{code: nil, name: nil, email: nil}

  def fixture(:history) do
    {:ok, history} = Histories.create_history(@create_attrs)
    history
  end

  defp create_history(_) do
    history = fixture(:history)
    {:ok, history: history}
  end

  describe "index" do
    setup [:create_history]
    test "lists histories not empty", %{conn: conn} do
      user = %Sapanboon.User{email: "some email"}
      conn = conn
              |> assign(:user, user)
              |> get(Routes.history_path(conn, :index))

      list_histories = conn.assigns.list_histories
      assert Enum.count(list_histories) == 1
    end

    test "lists histories is empty", %{conn: conn} do
      user = %Sapanboon.User{email: ""}
      conn = conn
              |> assign(:user, user)
              |> get(Routes.history_path(conn, :index))

      list_histories = conn.assigns.list_histories
      assert Enum.count(list_histories) == 0
    end
  end

  describe "create history" do
    test "gives a 200 response when data is valid", %{conn: conn} do
      response = conn
                |> post(Routes.history_path(conn, :create, @create_attrs), history: @invalid_attrs)
                |> json_response(200)

      expected = %{"data" => %{"code" => 1, "email" => "some email", "status" => "successfully", "title" => "some name"}}

      assert response == expected
    end
  end

  # describe "new history" do
  #   test "renders form", %{conn: conn} do
  #     conn = get(conn, Routes.history_path(conn, :new))
  #     assert html_response(conn, 200) =~ "New History"
  #   end
  # end



  # describe "edit history" do
  #   setup [:create_history]

  #   test "renders form for editing chosen history", %{conn: conn, history: history} do
  #     conn = get(conn, Routes.history_path(conn, :edit, history))
  #     assert html_response(conn, 200) =~ "Edit History"
  #   end
  # end

  # describe "update history" do
  #   setup [:create_history]

  #   test "redirects when data is valid", %{conn: conn, history: history} do
  #     conn = put(conn, Routes.history_path(conn, :update, history), history: @update_attrs)
  #     assert redirected_to(conn) == Routes.history_path(conn, :show, history)

  #     conn = get(conn, Routes.history_path(conn, :show, history))
  #     assert html_response(conn, 200) =~ "some updated code"
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, history: history} do
  #     conn = put(conn, Routes.history_path(conn, :update, history), history: @invalid_attrs)
  #     assert html_response(conn, 200) =~ "Edit History"
  #   end
  # end

  # describe "delete history" do
  #   setup [:create_history]

  #   test "deletes chosen history", %{conn: conn, history: history} do
  #     conn = delete(conn, Routes.history_path(conn, :delete, history))
  #     assert redirected_to(conn) == Routes.history_path(conn, :index)
  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.history_path(conn, :show, history))
  #     end
  #   end
  # end

  # defp create_history(_) do
  #   history = fixture(:history)
  #   {:ok, history: history}
  # end
end
