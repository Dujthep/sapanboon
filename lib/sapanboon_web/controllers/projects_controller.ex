defmodule SapanboonWeb.ProjectsController do
  use SapanboonWeb, :controller
  require Logger

  alias Sapanboon.Project
  alias Sapanboon.Histories
  alias Sapanboon.Histories.History

  def index(conn, params) do
    list_project = Project.list_project_by_status(Map.get(params, "status"), 1)
    IO.inspect(list_project)
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
          IO.inspect(body)

          params = %{
            amount: body["amount"],
            code: projects.code,
            email: conn.assigns[:user].email,
            full_name: conn.assigns[:user].name,
            status: "pending",
            name: projects.title,
            payment_type: "PromptPay",
            project_id: projects.project_id,
            trans_id: body["id"],
            trans_date: body["created"],
            trans_no: to_string(body["transactionNo"])
          }

          case Histories.create_history(params) do
            {:ok, _projects} ->
              conn
              |> put_flash(:info, "History created successfully.")
              |> redirect(to: Routes.payment_path(conn, :index, id))
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
    IO.inspect(list)
    json(conn, list)
  end
end
