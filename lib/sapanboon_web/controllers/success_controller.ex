defmodule SapanboonWeb.SuccessController do
  use SapanboonWeb, :controller

  alias Sapanboon.Histories
  alias Sapanboon.Histories.History

  def index(conn,  %{"id" => id}) do
    history = Histories.get_history!(id)
    render(conn, "index.html", history: history)
  end
end