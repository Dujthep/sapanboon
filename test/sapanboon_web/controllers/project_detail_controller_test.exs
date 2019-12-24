defmodule SapanboonWeb.ProjectDetailControllerTest do
  use SapanboonWeb.ConnCase

  @create_attrs %{name: "some name", project_id: "some project_id"}
  @update_attrs %{name: "some updated name", project_id: "some updated project_id"}
  @invalid_attrs %{name: nil, project_id: nil}

  def fixture(:project_detail) do
    {:ok, project_detail} = Project.create_project_detail(@create_attrs)
    project_detail
  end

  describe "index" do
    test "lists all project_detail", %{conn: conn} do
      conn = get(conn, Routes.project_detail_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Project detail"
    end
  end

  defp create_project_detail(_) do
    project_detail = fixture(:project_detail)
    {:ok, project_detail: project_detail}
  end
end
