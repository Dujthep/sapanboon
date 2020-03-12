defmodule SapanboonWeb.ProjectsController do
  use SapanboonWeb, :controller
  require Logger

  alias Sapanboon.Project
  alias Sapanboon.Project.Projects
  alias Sapanboon.Histories
  alias Sapanboon.Histories.History

  def index(conn, params) do
    month = ["ม.ค.","ก.พ.","มี.ค.","เม.ย.","พ.ค.","มิ.ย.","ก.ค.","ส.ค.","ก.ย.","ต.ค.","พ.ย.","ธ.ค."]
    list_project = Project.list_project_by_status(Map.get(params, "status"), 1)
    render(conn, "index.html", list_project: list_project, month: month)
  end

  def detail(conn, %{"id" => id}) do
    projects = Project.get_projects!(id)
    histories = Histories.list_histories_by_projectId(projects.projectId)
    transSum = Histories.sum_history(projects.projectId)
    render(conn, "detail.html", projects: projects, histories: histories, transSum: transSum)
  end

  def insert_transaction(conn, %{"id" => id, "amount" => amount, "fullName" => fullName}) do

    {id, _} = Integer.parse(id)

    {amount, _} = if amount == "on", 
      do:  :string.to_integer(to_char_list(String.replace(conn.query_params["inputAmount"], ",", ""))),
      else: Integer.parse(amount)

    url = Application.fetch_env!(:sapanboon, :api_transaction)
    paymentType = "PromptPay"
    statusPending = "pending"

    projects = Project.get_projects!(id)
    trans_params = %{
      ProjectID: projects.projectId, 
      Amount: amount,
      Email: conn.assigns[:user].email,
      PaymentType: paymentType,
      FullName: fullName
    }
    |> Poison.encode!()

    case HTTPoison.post(url <> "/transaction",trans_params,%{"Content-Type" => "application/json"}) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body = Poison.Parser.parse!(body)
        params = %{
          amount: body["amount"],
          code: projects.code,
          email: conn.assigns[:user].email,
          fullName: fullName,
          status: statusPending,
          name: projects.name,
          paymentType: paymentType,
          projectId: projects.projectId,
          transId: body["id"],
          transDate: body["created"],
          transNo: to_string(body["transactionNo"])
        }
    case Histories.create_history(params) do
      {:ok, history} ->
          conn
          |> put_flash(:info, "History created successfully.")
          |> redirect(to: Routes.payment_path(conn, :index, history.id))

        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> redirect(to: Routes.projects_path(conn, :detail, id))
      end
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def load_more(conn, params) do
    list = Project.list_project_by_status(Map.get(params, "status"), Map.get(params, "page"))
    json(conn, list)
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
        |> render(SapanboonWeb.ErrorView, "422.json")
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

  def delete(conn, %{"projectId" => projectId}) do
    case Project.get_projects_by_project_id(projectId) do
      projects ->
        case projects do
          nil ->
            conn
            |> put_status(404)
            |> render(SapanboonWeb.ErrorView, "404.json")

          %{} ->
            case Project.delete_projects(projects) do
              {:ok, _projects} ->
                conn
                |> put_status(:ok)
                |> render("show.json", projects: projects)
            end
        end
    end
  end

  def search(conn, %{"param" => param}) do
    json(conn, Project.get_project_by_param(param))
  end
end
