defmodule SapanboonWeb.Api.ProjectController do
  use SapanboonWeb, :controller
  require Logger

  alias Sapanboon.Project

  def index(conn, _params) do
    list_project = Project.list_project()
    render(conn, "index.json", list_project: list_project)
  end

  def create(conn, %{"params" => params}) do
    case Project.create_projects(params) do
      {:ok, project} ->
        conn
        |> put_status(:ok)
        |> render("show.json", project: project)

      {:error, %{errors: errors}} ->
        conn
        |> put_status(422)
        |> render(SapanboonWeb.ErrorView, "422.json")
    end
  end

  def update(conn, %{"project_id" => project_id, "params" => params}) do
    case Project.get_projects_by_project_id(project_id) do
      project ->
        case project do
          nil ->
            conn
            |> put_status(404)
            |> render(SapanboonWeb.ErrorView, "404.json")
          %{} ->
            case Project.update_projects(project, params) do
              {:ok, project} ->
                conn
                |> put_status(:ok)
                |> render("show.json", project: project)

              {:error, %{errors: errors}} ->
                conn
                |> put_status(422)
                |> render(SapanboonWeb.ErrorView, "422.json")
            end
        end
    end
  end

  def delete(conn, %{"project_id" => project_id}) do
    case Project.get_projects_by_project_id(project_id) do
      project ->
        case project do
          nil ->
            conn
            |> put_status(404)
            |> render(SapanboonWeb.ErrorView, "404.json")
          %{} ->
            case Project.delete_projects(project) do
              {:ok, _project} ->
                conn
                  |> put_status(:ok)
                  |> render("show.json", project: project)
            end
        end
    end
  end

end
