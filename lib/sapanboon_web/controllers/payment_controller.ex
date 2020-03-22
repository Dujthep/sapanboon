defmodule SapanboonWeb.PaymentController do
  use SapanboonWeb, :controller
  
  alias Sapanboon.Histories

  def index(conn, %{"id" => id}) do
    url_api = Application.fetch_env!(:sapanboon, :api_transaction)
    history = Histories.get_history!(id)
    render(conn, "index.html", history: history, url_api: url_api)
  end

end
