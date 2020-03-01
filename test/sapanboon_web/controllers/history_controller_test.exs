# defmodule SapanboonWeb.HistoryControllerTest do
#   use SapanboonWeb.ConnCase

#   alias Sapanboon.Histories

#   @create_attrs %{code: "some code", donation: 42, project_id: "some project_id", status: "some status", title: "some title", transDate: "2010-04-17T14:00:00Z", trans_id: "some trans_id"}
#   @update_attrs %{code: "some updated code", donation: 43, project_id: "some updated project_id", status: "some updated status", title: "some updated title", transDate: "2011-05-18T15:01:01Z", trans_id: "some updated trans_id"}
#   @invalid_attrs %{code: nil, donation: nil, project_id: nil, status: nil, title: nil, transDate: nil, trans_id: nil}

#   def fixture(:history) do
#     {:ok, history} = Histories.create_history(@create_attrs)
#     history
#   end

#   describe "index" do
#     test "lists all histories", %{conn: conn} do
#       conn = get(conn, Routes.history_path(conn, :index))
#       assert html_response(conn, 200) =~ "Listing Histories"
#     end
#   end

#   describe "new history" do
#     test "renders form", %{conn: conn} do
#       conn = get(conn, Routes.history_path(conn, :new))
#       assert html_response(conn, 200) =~ "New History"
#     end
#   end

#   describe "create history" do
#     test "redirects to show when data is valid", %{conn: conn} do
#       conn = post(conn, Routes.history_path(conn, :create), history: @create_attrs)

#       assert %{id: id} = redirected_params(conn)
#       assert redirected_to(conn) == Routes.history_path(conn, :show, id)

#       conn = get(conn, Routes.history_path(conn, :show, id))
#       assert html_response(conn, 200) =~ "Show History"
#     end

#     test "renders errors when data is invalid", %{conn: conn} do
#       conn = post(conn, Routes.history_path(conn, :create), history: @invalid_attrs)
#       assert html_response(conn, 200) =~ "New History"
#     end
#   end

#   describe "edit history" do
#     setup [:create_history]

#     test "renders form for editing chosen history", %{conn: conn, history: history} do
#       conn = get(conn, Routes.history_path(conn, :edit, history))
#       assert html_response(conn, 200) =~ "Edit History"
#     end
#   end

#   describe "update history" do
#     setup [:create_history]

#     test "redirects when data is valid", %{conn: conn, history: history} do
#       conn = put(conn, Routes.history_path(conn, :update, history), history: @update_attrs)
#       assert redirected_to(conn) == Routes.history_path(conn, :show, history)

#       conn = get(conn, Routes.history_path(conn, :show, history))
#       assert html_response(conn, 200) =~ "some updated code"
#     end

#     test "renders errors when data is invalid", %{conn: conn, history: history} do
#       conn = put(conn, Routes.history_path(conn, :update, history), history: @invalid_attrs)
#       assert html_response(conn, 200) =~ "Edit History"
#     end
#   end

#   describe "delete history" do
#     setup [:create_history]

#     test "deletes chosen history", %{conn: conn, history: history} do
#       conn = delete(conn, Routes.history_path(conn, :delete, history))
#       assert redirected_to(conn) == Routes.history_path(conn, :index)
#       assert_error_sent 404, fn ->
#         get(conn, Routes.history_path(conn, :show, history))
#       end
#     end
#   end

#   defp create_history(_) do
#     history = fixture(:history)
#     {:ok, history: history}
#   end
# end
