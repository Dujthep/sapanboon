defmodule SapanboonWeb.ProjectsController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project

  def index(conn, params) do
    list_project = Project.list_project_by_status(Map.get(params, "status"))
    render(conn, "index.html", list_project: list_project, conn: conn )
  end

  def detail(conn, %{"id" => id}) do
    projects = Project.get_projects!(id)
    IO.inspect(projects.id)
    render(conn, "detail.html", projects: projects)
  end
  
end
