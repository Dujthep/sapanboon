defmodule SapanboonWeb.PaymentController do
  use SapanboonWeb, :controller

  alias Sapanboon.Histories
  alias Sapanboon.QRcode

  def index(conn, %{"id" => id}) do
    url_api = Application.fetch_env!(:sapanboon, :api_transaction)
    history = Histories.get_history!(id)

    qrcode =
      QRcode.generate_qr_code(
        history.amount,
        Integer.to_string(history.transactionNo),
        "SPB" <> Integer.to_string(history.code)
      ).data.qrImage

    render(conn, "index.html", history: history, url_api: url_api, meta_attrs: [], qrcode: qrcode)
  end

  def checkStatus(conn, %{"id" => id}) do
    history = Histories.get_history!(id)
    json(conn, %{status: history.status, transId: history.transId})
  end
end
