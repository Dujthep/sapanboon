defmodule SapanboonWeb.PaymentController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project
  alias Sapanboon.History

  def index(conn, %{"id" => id}) do
    projects = Project.get_projects!(id)
    params = %{
      status: "pending"
    }
    case History.create_trans(params) do
      {:ok, history} ->
        conn
        |> put_status(:ok)
        |> render("show.json", history: history)
    end

    render(conn, "index.html", projects: projects)
  end

end
