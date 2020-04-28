defmodule SapanboonWeb.ProjectsController do
  use SapanboonWeb, :controller
  require Logger

  alias Sapanboon.Project
  alias Sapanboon.Project.Projects
  alias Sapanboon.Histories
  alias SapanboonWeb.HttpWrapper

  def index(conn, params) do
    render(conn, "index.html",
      list_project: Project.list_project_by_status(Map.get(params, "status"), 1),
      count: Project.count_project(Map.get(params, "status")),
      meta_attrs: []
    )
  end

  def detail(conn, %{"id" => id}) do
    project = Enum.at(Project.get_projects_detail(id), 0)

    attrs_list = [
      %{name: "og:description", content: project.introduce},
      %{property: "og:image", content: project.images2},
      %{name: "og:title", content: project.name}
    ]

    render(conn, "detail.html", projects: project, meta_attrs: attrs_list)
  end

  def create_transaction(conn, %{"id" => id, "amount" => amount, "fullName" => fullName}) do

    {amount, _} = Integer.parse(amount |> String.split(",") |> Enum.join)
    projects = Project.get_projects!(id)
    paymentType = "PromptPay"
    statusPending = "pending"

    params =
      %{
        ProjectID: projects.projectId,
        Amount: amount,
        Email: conn.assigns[:user].email,
        PaymentType: paymentType,
        FullName: fullName
      }
      |> Poison.encode!()

    url = Application.fetch_env!(:sapanboon, :api_transaction)

    options = %{"Content-Type" => "application/json"}
    case HttpWrapper.post(url <> "/transaction", params, options) do
      {:ok, body} ->
        Logger.info("body: #{inspect(body)}")
        params = %{
          amount: body.amount,
          code: projects.code,
          email: conn.assigns[:user].email,
          fullName: fullName,
          status: statusPending,
          name: projects.name,
          paymentType: paymentType,
          projectId: projects.projectId,
          transId: body.id,
          transactionDate: body.created,
          transactionNo: to_string(body.transactionNo)
        }

      case Histories.create_history(params) do
        {:ok, history} ->
          conn
          |> put_flash(:info, "History created successfully.")
          |> redirect(to: Routes.payment_path(conn, :index, history.id))
        {:error, _} ->
          Logger.error("error create_history")
          conn
          |> put_view(SapanboonWeb.ErrorView)
          |> render("500.html")
      end
    {:error, reason} ->
      Logger.error("error http post: #{inspect(reason)}")
      conn
      |> put_view(SapanboonWeb.ErrorView)
      |> render("500.html")
    end

  end

  def load_more(conn, params) do
    json(
      conn,
      %{
        list_project:
          Project.list_project_by_status(Map.get(params, "status"), Map.get(params, "page")),
        count: Project.count_project(Map.get(params, "status"))
      }
    )
  end

  def create(conn, params) do
    case Project.create_projects(params) do
      {:ok, projects} ->
        conn
        |> put_status(:ok)
        |> render("show.json", projects: projects)

      {:error, %{errors: errors}} ->
        conn
        |> put_status(422)
        |> put_view(SapanboonWeb.ErrorView)
        |> render("422.json", errors)
    end
  end

  def update(conn, params) do
    projects =
      case Project.get_projects_by_project_id(Map.get(params, "projectId")) do
        projects ->
          case projects do
            nil -> %Projects{projectId: Map.get(params, "projectId")}
            projects -> projects
          end
      end

    case Project.insert_or_update_projects(projects, params) do
      {:ok, projects} ->
        conn
        |> put_status(:ok)
        |> render("show.json", projects: projects)

      {:error, %{errors: errors}} ->
        conn
        |> put_status(422)
        |> put_view(SapanboonWeb.ErrorView)
        |> render("422.json", errors)
    end
  end

  def search(conn, %{"param" => param}) do
    json(conn, Project.search_project(param))
  end
end
