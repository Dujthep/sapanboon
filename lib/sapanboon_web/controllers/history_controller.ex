defmodule SapanboonWeb.HistoryController do
  use SapanboonWeb, :controller

  alias Sapanboon.Histories
  alias Sapanboon.Histories.History

  alias Sapanboon.{Mailer, Email}

  def index(conn, _params) do
    list_histories = Histories.list_histories_by_email()
    render(conn, "index.html", list_histories: list_histories)
  end

  def cancel_trans(conn, %{"id" => id, "status" => status}) do
    # status_params = %{"status" => status}
    # history = Histories.get_history!(id)
    Email.send_email_payment("sothon@odds.team") |> Mailer.deliver_later()
    json(conn, "Cancel Transaltion successfully.")
    # case Histories.update_history(history, status_params) do
    #   {:ok, _history} ->
    #     json(conn, "Cancel Transaltion successfully.")
    #   {:error } ->
    #     json(conn, "Cancel Transaltion Error.")
    # end
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
