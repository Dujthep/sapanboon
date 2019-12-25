defmodule SapanboonWeb.ProjectsController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project
  alias Sapanboon.Project.Projects

  def index(conn, _params) do
    list_project = Project.list_project()
    render(conn, "index.html", list_project: list_project)
  end

end
