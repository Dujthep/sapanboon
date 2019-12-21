defmodule SapanboonWeb.ProjectsController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project
  alias Sapanboon.Project.Projects

  def index(conn, _params) do
    aaa = Project.list_project()
    render(conn, "index.html", aaa: aaa)
  end

end
