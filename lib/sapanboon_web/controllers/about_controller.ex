defmodule SapanboonWeb.AboutController do
  use SapanboonWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", abouts: "")
  end

end
