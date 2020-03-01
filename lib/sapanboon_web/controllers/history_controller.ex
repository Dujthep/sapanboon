defmodule SapanboonWeb.HistoryController do
  use SapanboonWeb, :controller

  alias Sapanboon.Histories
  alias Sapanboon.Histories.History

  alias Sapanboon.{Mailer, Email}

  def index(conn, _params) do
    list_histories = Histories.list_histories_by_email()
    render(conn, "index.html", list_histories: list_histories)
  end

  def update_transaction(conn, params) do
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
                mail_user = %{
                  projectName: history.name,
                  email: history.email,
                  fullName: history.fullName,
                  amount: history.amount,
                  paymentType: history.paymentType,
                  transactionNo: history.transNo,
                  day: "10", month: "มกราคม", year: "2563", time: "10:00",
                  status: "รอตรวจสอบเอกสาร"
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

  def new(conn, _params) do
    changeset = Histories.change_history(%History{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"history" => history_params}) do
    case Histories.create_history(history_params) do
      {:ok, history} ->
        conn
        |> put_flash(:info, "History created successfully.")
        |> redirect(to: Routes.history_path(conn, :show, history))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    history = Histories.get_history!(id)
    render(conn, "show.html", history: history)
  end

  def edit(conn, %{"id" => id}) do
    history = Histories.get_history!(id)
    changeset = Histories.change_history(history)
    render(conn, "edit.html", history: history, changeset: changeset)
  end

  def update(conn, %{"id" => id, "history" => history_params}) do
    history = Histories.get_history!(id)

    case Histories.update_history(history, history_params) do
      {:ok, history} ->
        conn
        |> put_flash(:info, "History updated successfully.")
        |> redirect(to: Routes.history_path(conn, :show, history))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", history: history, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    history = Histories.get_history!(id)
    {:ok, _history} = Histories.delete_history(history)

    conn
    |> put_flash(:info, "History deleted successfully.")
    |> redirect(to: Routes.history_path(conn, :index))
  end
end
