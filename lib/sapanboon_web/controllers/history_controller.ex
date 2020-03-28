defmodule SapanboonWeb.HistoryController do
  use SapanboonWeb, :controller

  alias Sapanboon.Histories
  alias Sapanboon.Histories.History

  alias Sapanboon.{Mailer, Email}

  def index(conn, _params) do
    month = [
      "ม.ค.",
      "ก.พ.",
      "มี.ค.",
      "เม.ย.",
      "พ.ค.",
      "มิ.ย.",
      "ก.ค.",
      "ส.ค.",
      "ก.ย.",
      "ต.ค.",
      "พ.ย.",
      "ธ.ค."
    ]
    url_api = Application.fetch_env!(:sapanboon, :api_transaction)
    list_histories = Histories.get_history_list_by_email(conn.assigns[:user].email)
    render(conn, "index.html", list_histories: list_histories, url_api: url_api, month: month,meta_attrs: [])
  end

  def update(conn, params) do
    case Histories.get_history_by_trans_id(Map.get(params, "transId")) do
      history ->
        case history do
          nil ->
            conn
            |> put_status(404)
            |> put_view(SapanboonWeb.ErrorView)
            |> render("404.json")
          %{} ->
            case Histories.update_history(history, params) do
              {:ok, history} ->
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
        |> render(SapanboonWeb.ErrorView, "422.json")
    end
  end

end
