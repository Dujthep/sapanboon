defmodule SapanboonWeb.SuccessControllerTest do
  use SapanboonWeb.ConnCase

  alias Sapanboon.SapanboonWeb

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:success) do
    {:ok, success} = SapanboonWeb.create_success(@create_attrs)
    success
  end

  describe "index" do
    test "lists all success", %{conn: conn} do
      conn = get(conn, Routes.success_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Success"
    end
  end

  describe "new success" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.success_path(conn, :new))
      assert html_response(conn, 200) =~ "New Success"
    end
  end

  describe "create success" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.success_path(conn, :create), success: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.success_path(conn, :show, id)

      conn = get(conn, Routes.success_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Success"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.success_path(conn, :create), success: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Success"
    end
  end

  describe "edit success" do
    setup [:create_success]

    test "renders form for editing chosen success", %{conn: conn, success: success} do
      conn = get(conn, Routes.success_path(conn, :edit, success))
      assert html_response(conn, 200) =~ "Edit Success"
    end
  end

  describe "update success" do
    setup [:create_success]

    test "redirects when data is valid", %{conn: conn, success: success} do
      conn = put(conn, Routes.success_path(conn, :update, success), success: @update_attrs)
      assert redirected_to(conn) == Routes.success_path(conn, :show, success)

      conn = get(conn, Routes.success_path(conn, :show, success))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, success: success} do
      conn = put(conn, Routes.success_path(conn, :update, success), success: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Success"
    end
  end

  describe "delete success" do
    setup [:create_success]

    test "deletes chosen success", %{conn: conn, success: success} do
      conn = delete(conn, Routes.success_path(conn, :delete, success))
      assert redirected_to(conn) == Routes.success_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.success_path(conn, :show, success))
      end
    end
  end

  defp create_success(_) do
    success = fixture(:success)
    {:ok, success: success}
  end
end
