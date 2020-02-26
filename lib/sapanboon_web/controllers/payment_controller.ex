defmodule SapanboonWeb.PaymentController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project
  alias Sapanboon.Histories
  alias Sapanboon.Histories.History
  alias Sapanboon.{Mailer, Email}

  def index(conn, %{"id" => id}) do
    history = Histories.get_history!(id)
    IO.inspect(history)
    render(conn, "index.html", history: history)
  end

  def update_transaction(conn, params) do
    id = Map.get(params, "id")
    case Histories.get_history!(id) do
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
                json(conn, %{
                  id: history.id,
                  msg: "History updated successfully.",
                })
              {:error, %Ecto.Changeset{} = changeset} ->
                json(conn, "History updated Error.")
            end
        end

        params = %{
          projectName: history.name,
          email: history.email,
          fullName: history.fullName,
          amount: history.amount,
          paymentType: history.paymentType,
          transactionNo: history.transNo,
          day: "10", month: "มกราคม", year: "2563", time: "10:00",
          project_id: history.projectId,
          subject: "รอตรวจสอบเอกสาร : "<>history.name
        }
        Email.send_email_payment(params) |> Mailer.deliver_later()
    end
  end

end
