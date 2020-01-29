# defmodule SapanboonWeb.ProjectsControllerTest do
#   use SapanboonWeb.ConnCase

#   alias Sapanboon.Project

#   @create_attrs %{code: "some code", cover: "some cover", description: "some description", donation: 42, donator: 42, end_date: "2010-04-17T14:00:00Z", pledged_goal: 42, project_id: "some project_id", start_date: "2010-04-17T14:00:00Z", status: "some status", title: "some title"}
#   @update_attrs %{code: "some updated code", cover: "some updated cover", description: "some updated description", donation: 43, donator: 43, end_date: "2011-05-18T15:01:01Z", pledged_goal: 43, project_id: "some updated project_id", start_date: "2011-05-18T15:01:01Z", status: "some updated status", title: "some updated title"}
#   @invalid_attrs %{code: nil, cover: nil, description: nil, donation: nil, donator: nil, end_date: nil, pledged_goal: nil, project_id: nil, start_date: nil, status: nil, title: nil}

#   def fixture(:projects) do
#     {:ok, projects} = Project.create_projects(@create_attrs)
#     projects
#   end

#   describe "index" do
#     test "lists all project", %{conn: conn} do
#       conn = get(conn, Routes.projects_path(conn, :index))
#       assert html_response(conn, 200) =~ "Listing Project"
#     end
#   end

#   describe "new projects" do
#     test "renders form", %{conn: conn} do
#       conn = get(conn, Routes.projects_path(conn, :new))
#       assert html_response(conn, 200) =~ "New Projects"
#     end
#   end

#   describe "create projects" do
#     test "redirects to show when data is valid", %{conn: conn} do
#       conn = post(conn, Routes.projects_path(conn, :create), projects: @create_attrs)

#       assert %{id: id} = redirected_params(conn)
#       assert redirected_to(conn) == Routes.projects_path(conn, :show, id)

#       conn = get(conn, Routes.projects_path(conn, :show, id))
#       assert html_response(conn, 200) =~ "Show Projects"
#     end

#     test "renders errors when data is invalid", %{conn: conn} do
#       conn = post(conn, Routes.projects_path(conn, :create), projects: @invalid_attrs)
#       assert html_response(conn, 200) =~ "New Projects"
#     end
#   end

#   describe "edit projects" do
#     setup [:create_projects]

#     test "renders form for editing chosen projects", %{conn: conn, projects: projects} do
#       conn = get(conn, Routes.projects_path(conn, :edit, projects))
#       assert html_response(conn, 200) =~ "Edit Projects"
#     end
#   end

#   describe "update projects" do
#     setup [:create_projects]

#     test "redirects when data is valid", %{conn: conn, projects: projects} do
#       conn = put(conn, Routes.projects_path(conn, :update, projects), projects: @update_attrs)
#       assert redirected_to(conn) == Routes.projects_path(conn, :show, projects)

#       conn = get(conn, Routes.projects_path(conn, :show, projects))
#       assert html_response(conn, 200) =~ "some updated code"
#     end

#     test "renders errors when data is invalid", %{conn: conn, projects: projects} do
#       conn = put(conn, Routes.projects_path(conn, :update, projects), projects: @invalid_attrs)
#       assert html_response(conn, 200) =~ "Edit Projects"
#     end
#   end

#   describe "delete projects" do
#     setup [:create_projects]

#     test "deletes chosen projects", %{conn: conn, projects: projects} do
#       conn = delete(conn, Routes.projects_path(conn, :delete, projects))
#       assert redirected_to(conn) == Routes.projects_path(conn, :index)
#       assert_error_sent 404, fn ->
#         get(conn, Routes.projects_path(conn, :show, projects))
#       end
#     end
#   end

#   defp create_projects(_) do
#     projects = fixture(:projects)
#     {:ok, projects: projects}
#   end
# end
