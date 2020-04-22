defmodule SapanboonWeb.ContabControllerTest do
  use SapanboonWeb.ConnCase
  alias Sapanboon.Project

  @create_attrs %{code: 1, projectId: "mock projectId", name: "mock name"}

  def fixture(:projects) do
    {:ok, projects} = Project.create_projects(@create_attrs)
    projects
  end

  defp create_projects(_) do
    projects = fixture(:projects)
    {:ok, projects: projects}
  end

  describe "contab" do
    setup [:create_projects]

    test "Update when projectId not found gives a 404 response", %{conn: conn} do
      params = %{projectId: "", projectStatus: ""}
      actual = conn
            |> put(Routes.crontab_path(conn, :update, params))
            |> json_response(404)

      expected = %{"errors" => %{"message" => "Page not found"}}
      assert actual == expected
    end

    test "Update by projectStatus is pending gives a 200 response", %{conn: conn} do
      params = %{projectId: "mock projectId", projectStatus: "pending"}
      actual = conn
            |> put(Routes.crontab_path(conn, :update, params))
            |> json_response(200)
      expected = %{
        "data" => %{
          "code" => 1,
          "status" => "successfully",
          "name" => "mock name"
          }
        }
      assert actual == expected
    end

  end

end
