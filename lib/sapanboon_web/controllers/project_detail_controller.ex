defmodule SapanboonWeb.ProjectDetailController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project
  alias Sapanboon.Project.ProjectDetail

  def index(conn, _params) do
    project_detail = Project.list_project_detail()
    render(conn, "index.html", project_detail: project_detail)
  end

end
