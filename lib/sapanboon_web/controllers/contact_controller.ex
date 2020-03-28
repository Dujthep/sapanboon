defmodule SapanboonWeb.ContactController do
  use SapanboonWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html",meta_attrs: [])
  end
end
