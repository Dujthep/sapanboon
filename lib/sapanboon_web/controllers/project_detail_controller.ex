defmodule SapanboonWeb.ProjectDetailController do
  use SapanboonWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
