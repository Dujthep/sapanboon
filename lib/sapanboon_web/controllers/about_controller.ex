defmodule SapanboonWeb.AboutController do
  use SapanboonWeb, :controller

  alias Sapanboon.Abouts
  alias Sapanboon.Abouts.About

  def index(conn, _params) do
    render(conn, "index.html", abouts: "")
  end
  
end
