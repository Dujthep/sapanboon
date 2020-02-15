defmodule SapanboonWeb.PaymentController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project

  def index(conn, %{"id" => id}) do
    projects = Project.get_projects!(id)
    render(conn, "index.html", projects: projects)
  end

end
