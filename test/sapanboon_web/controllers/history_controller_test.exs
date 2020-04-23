defmodule SapanboonWeb.HistoryControllerTest do
  use SapanboonWeb.ConnCase

  alias Sapanboon.Histories

  @history_attrs %{id: 1, projectId: "mock projectId", code: 1, name: "mock name", email: "mock email", transId: "mock transId", transactionDate: "2010-04-17T14:00:00Z", transactionNo: 1, amount: 1000, status: "mock status", imgSlip: "mock imgSlip", paymentType: "mock paymentType", fullName: "mock fullName"}

  def fixture(:history) do
    {:ok, history} = Histories.create_history(@history_attrs)
    history
  end

  defp create_history(_) do
    history = fixture(:history)
    {:ok, history: history}
  end

  describe "index" do
    setup [:create_history]

    test "lists histories not empty", %{conn: conn} do
      user = %Sapanboon.User{email: "mock email"}
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
    test "gives a status 200 when data is valid", %{conn: conn} do
      actual = conn
                |> post(Routes.history_path(conn, :create, @history_attrs))
                |> json_response(200)

      expected = %{"data" => %{"code" => 1, "email" => "mock email", "status" => "successfully", "title" => "mock name"}}

      assert actual == expected
    end
  end

  describe "update history" do
    setup [:create_history]

    test "gives a status 404 when transId is nil", %{conn: conn} do
      params = %{transId: nil}
      actual = conn
            |> put(Routes.history_path(conn, :update, params))
            |> json_response(404)

      expected = %{"errors" => %{"message" => "Page not found"}}

      assert actual == expected
    end

    test "gives a status 200 when update success", %{conn: conn} do
      actual = conn
                |> put(Routes.history_path(conn, :update, @history_attrs))
                |> json_response(200)

      expected = %{"data" => %{"code" => 1, "email" => "mock email", "status" => "successfully", "title" => "mock name"}}
      assert actual == expected
    end

  end

end
