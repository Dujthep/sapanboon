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
    IO.inspect(projects)
    histories = Histories.list_histories_by_projectId()
    render(conn, "detail.html", projects: projects, histories: histories)
  end

  def insert_transaction(conn, %{"id" => id, "amount" => amount, "fullName"  => fullName}) do
    {id, _} = Integer.parse(id)
    {amount, _} = Integer.parse(amount)

    url = "http://localhost:8080"
    paymentType = "PromptPay"
    statusPending = "pending"

    projects = Project.get_projects!(id)
    IO.inspect(projects)

    trans_params = %{
      ProjectID: projects.projectId,
      Amount: amount,
      Email: conn.assigns[:user].email,
      PaymentType: paymentType,
      FullName: fullName
    } |> Poison.encode!

      case HTTPoison.post(
            url<>"/transaction", trans_params,
            %{"Content-Type" => "application/json"}
        ) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body }} ->
          body = Poison.Parser.parse!(body)
          IO.inspect(body)

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
