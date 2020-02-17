defmodule SapanboonWeb.ProjectsController do
  use SapanboonWeb, :controller
  require Logger

  alias Sapanboon.Project
  alias Sapanboon.Histories
  alias Sapanboon.Histories.History

  def index(conn, params) do
    list_project = Project.list_project_by_status(Map.get(params, "status"), 1)
    render(conn, "index.html", list_project: list_project, conn: conn )
  end

  def detail(conn, %{"id" => id}) do
    projects = Project.get_projects!(id)
    render(conn, "detail.html", projects: projects)
  end

  def insert_transaction(conn, %{"id" => id}) do
    projects = Project.get_projects!(id)

    trans_params = %{
      ProjectID: projects.project_id,
      Amount: 1000,
      Email: conn.assigns[:user].email,
      PaymentType: "PromptPay",
      FullName: conn.assigns[:user].name
    }

      case HTTPoison.post(
            "https://beta.api.sapanboon.org/transaction",
            URI.encode_query(trans_params),
            %{"Content-Type" => "application/x-www-form-urlencoded"}
        ) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body }} ->
          body = Poison.Parser.parse!(body)

          params = %{
            project_id: projects.project_id,
            code: projects.code,
            name: projects.title,
            status: "pending",
            payment_type: "promptPay",
            full_name: conn.assigns[:user].name,
            email: conn.assigns[:user].email,
            trans_id: body["id"]
          }

          case Histories.create_history(params) do
            {:ok, _projects} ->
              conn
              |> put_flash(:info, "History created successfully.")
              |> redirect(to: Routes.payment_path(conn, :index, id))
              # |> redirect(to: Routes.projects_path(conn, :detail, id))
            {:error, %Ecto.Changeset{} = changeset} ->
              conn
              |> redirect(to: Routes.projects_path(conn, :detail, id))
          end

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  def load_more(conn, params) do
    list = Project.list_project_by_status(Map.get(params, "status"), Map.get(params, "page"))
    json(conn, list)
  end
end
