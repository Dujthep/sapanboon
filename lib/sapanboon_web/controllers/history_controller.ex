defmodule SapanboonWeb.HistoryController do
  use SapanboonWeb, :controller

  alias Sapanboon.Histories
  alias Sapanboon.{Mailer, Email}

  def index(conn, _params) do
    list_histories = Histories.get_history_list_by_email(conn.assigns[:user].email)
    render(conn, "index.html", list_histories: list_histories, meta_attrs: [])
  end

  def update(conn, params) do
    case Histories.find_by_trans_id_and_update_history(Map.get(params, "transId"), params) do
      {:ok, history} ->
        send_mail(history)
        conn
        |> put_status(:ok)
        |> render("show.json", history: history)
      {:error, %{errors: errors}} ->
        conn
        |> put_status(422)
        |> put_view(SapanboonWeb.ErrorView)
        |> render("422.json", errors)
    end
  end

  def send_mail(history) do
    map_status = %{
      "pending" => "รอตรวจสอบเอกสาร",
      "approved" => "อนุมัติการบริจาค",
      "cancel" => "ยกเลิกการบริจาค",
      "reject" => "ไม่อนุมัติการบริจาค"
    }
    dateTime = Calendar.DateTime.now! "Asia/Bangkok"
    mail_user = %{
      projectName: history.name,
      email: history.email,
      fullName: history.fullName,
      amount: history.amount,
      paymentType: history.paymentType,
      transactionNo: history.transactionNo,
      dateTime: dateTime,
      status: map_status[history.status]
    }
    Email.send_email(mail_user) |> Mailer.deliver_later()
  end

  def create(conn, params) do
    case Histories.create_history(params) do
      {:ok, history} ->
        conn
        |> put_status(:ok)
        |> render("show.json", history: history)

      {:error, %{errors: errors}} ->
        conn
        |> put_status(422)
        |> put_view(SapanboonWeb.ErrorView)
        |> render("422.json", errors)
    end
  end

end
