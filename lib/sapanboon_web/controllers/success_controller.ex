defmodule SapanboonWeb.SuccessController do
  use SapanboonWeb, :controller

  alias Sapanboon.Histories

  def index(conn,  %{"id" => id}) do
    history = Histories.get_history!(id)
    render(conn, "index.html", history: history,meta_attrs: [])
  end
end