defmodule SapanboonWeb.ProjectsController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project
  alias Sapanboon.Project.Projects

  def index(conn, %{"status" => status}) do
    list_project = Project.list_project_by_status(status)
    render(conn, "index.html", list_project: list_project)
  end

  def detail(conn, %{"id" => id}) do
    projects = Project.get_projects!(id)
    render(conn, "detail.html", projects: projects)
  end


end
