defmodule SapanboonWeb.LoginController do
  use SapanboonWeb, :controller

  alias Sapanboon.SapanboonWeb
  alias Sapanboon.SapanboonWeb.Login

  def index(conn, _params) do
    render(conn, "index.html", login: "")
  end

end
