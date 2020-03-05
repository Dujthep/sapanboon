defmodule SapanboonWeb.PaymentController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project
  alias Sapanboon.Histories
  alias Sapanboon.Histories.History
  alias Sapanboon.{Mailer, Email}

  def index(conn, %{"id" => id}) do
    url_api = Application.fetch_env!(:sapanboon, :api_transaction)
    history = Histories.get_history!(id)
    IO.inspect(history)
    render(conn, "index.html", history: history)
  end

end
