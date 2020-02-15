defmodule SapanboonWeb.PaymentController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project

  def index(conn, %{"id" => id}) do
    projects = Project.get_projects!(id)

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

    render(conn, "index.html", projects: projects)
  end

end
