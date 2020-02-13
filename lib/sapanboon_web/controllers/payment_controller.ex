defmodule SapanboonWeb.PaymentController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project
  # alias Sapanboon.Histories
  # alias Sapanboon.Histories.History

  def index(conn, %{"id" => id}) do
    projects = Project.get_projects!(id)
    render(conn, "index.html", projects: projects)
  end

end

    # params = %{
    #   status: "pending"
    # }

    # case Histories.create_history(params) do
    #   {:ok,_projects} ->
    #     conn
    #     |> put_flash(:info, "History created successfully.")
    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     render(conn, "new.html", changeset: changeset)
    # end