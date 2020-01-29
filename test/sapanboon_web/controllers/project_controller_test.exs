# defmodule SapanboonWeb.ProjectControllerTest do
#   use SapanboonWeb.ConnCase

#   alias Sapanboon.Projects

#   @create_attrs %{"": 42, code: "some code", cover: "some cover", description: "some description", donation: "some donation", donator: "some donator", end_date: "some end_date", pledged_goal: "some pledged_goal", project_id: "some project_id", start_date: "some start_date", status: "some status", title: "some title"}
#   @update_attrs %{"": 43, code: "some updated code", cover: "some updated cover", description: "some updated description", donation: "some updated donation", donator: "some updated donator", end_date: "some updated end_date", pledged_goal: "some updated pledged_goal", project_id: "some updated project_id", start_date: "some updated start_date", status: "some updated status", title: "some updated title"}
#   @invalid_attrs %{"": nil, code: nil, cover: nil, description: nil, donation: nil, donator: nil, end_date: nil, pledged_goal: nil, project_id: nil, start_date: nil, status: nil, title: nil}

#   def fixture(:project) do
#     {:ok, project} = Projects.create_project(@create_attrs)
#     project
#   end

#   describe "index" do
#     test "lists all project", %{conn: conn} do
#       conn = get(conn, Routes.project_path(conn, :index))
#       assert html_response(conn, 200) =~ "Listing Project"
#     end
#   end

#   describe "new project" do
#     test "renders form", %{conn: conn} do
#       conn = get(conn, Routes.project_path(conn, :new))
#       assert html_response(conn, 200) =~ "New Project"
#     end
#   end

#   describe "create project" do
#     test "redirects to show when data is valid", %{conn: conn} do
#       conn = post(conn, Routes.project_path(conn, :create), project: @create_attrs)

#       assert %{id: id} = redirected_params(conn)
#       assert redirected_to(conn) == Routes.project_path(conn, :show, id)

#       conn = get(conn, Routes.project_path(conn, :show, id))
#       assert html_response(conn, 200) =~ "Show Project"
#     end

#     test "renders errors when data is invalid", %{conn: conn} do
#       conn = post(conn, Routes.project_path(conn, :create), project: @invalid_attrs)
#       assert html_response(conn, 200) =~ "New Project"
#     end
#   end

#   describe "edit project" do
#     setup [:create_project]

#     test "renders form for editing chosen project", %{conn: conn, project: project} do
#       conn = get(conn, Routes.project_path(conn, :edit, project))
#       assert html_response(conn, 200) =~ "Edit Project"
#     end
#   end

#   describe "update project" do
#     setup [:create_project]

#     test "redirects when data is valid", %{conn: conn, project: project} do
#       conn = put(conn, Routes.project_path(conn, :update, project), project: @update_attrs)
#       assert redirected_to(conn) == Routes.project_path(conn, :show, project)

#       conn = get(conn, Routes.project_path(conn, :show, project))
#       assert html_response(conn, 200) =~ "some updated code"
#     end

#     test "renders errors when data is invalid", %{conn: conn, project: project} do
#       conn = put(conn, Routes.project_path(conn, :update, project), project: @invalid_attrs)
#       assert html_response(conn, 200) =~ "Edit Project"
#     end
#   end

#   describe "delete project" do
#     setup [:create_project]

#     test "deletes chosen project", %{conn: conn, project: project} do
#       conn = delete(conn, Routes.project_path(conn, :delete, project))
#       assert redirected_to(conn) == Routes.project_path(conn, :index)
#       assert_error_sent 404, fn ->
#         get(conn, Routes.project_path(conn, :show, project))
#       end
#     end
#   end

#   defp create_project(_) do
#     project = fixture(:project)
#     {:ok, project: project}
#   end
# end
