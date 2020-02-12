defmodule SapanboonWeb.Api.ProjectController do
  use SapanboonWeb, :controller

  alias Sapanboon.Api

  def index(conn, _params) do
    list_project = list_project = Api.list_project()
    render(conn, "index.json", list_project: list_project)
  end

end