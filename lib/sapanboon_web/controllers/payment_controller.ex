defmodule SapanboonWeb.PaymentController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project
  alias Sapanboon.Histories
  alias Sapanboon.Histories.History

  def index(conn, %{"id" => id}) do
    projects = Project.get_projects!(id)
    render(conn, "index.html", projects: projects)
  end

  def update_transaction(conn, %{"id" => id}) do

    history = Histories.get_history!(id)

    # case Histories.update_history(history) do
    #   {:ok, history} ->
    #     conn
    #     |> put_flash(:info, "History updated successfully.")
    #     |> redirect(to: Routes.payment_path(conn, :index, id))

    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     conn
        |> redirect(to: Routes.payment_path(conn, :index, id))
    # end
  end

end
