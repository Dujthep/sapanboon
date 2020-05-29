defmodule SapanboonWeb.PaymentController do
  use SapanboonWeb, :controller

  alias Sapanboon.Histories
  alias Sapanboon.QRcode

  def index(conn, %{"id" => id}) do
    url_api = Application.fetch_env!(:sapanboon, :api_transaction)
    history = Histories.get_history!(id)
    qrcode = QRcode.generateQRcode(
      history.amount, 
      Integer.to_string(history.transactionNo), 
      "SPB" <> Integer.to_string(history.code)
    )["data"]["qrImage"]
    render(conn, "index.html", history: history, url_api: url_api,meta_attrs: [], qrcode: qrcode)
  end



end
