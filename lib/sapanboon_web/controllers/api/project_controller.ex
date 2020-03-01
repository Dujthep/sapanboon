defmodule SapanboonWeb.Api.ProjectController do
  use SapanboonWeb, :controller
  require Logger

  alias Sapanboon.Project
  alias Sapanboon.Project.Projects

  def index(conn, _params) do
    list_project = Project.list_project()
    render(conn, "index.json", list_project: list_project)
  end

  def create(conn, params) do
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

  def update(conn, params) do
    project = case Project.get_projects_by_project_id(Map.get(params, "projectId")) do
      project ->
        case project do
          nil -> %Projects{projectId: Map.get(params, "projectId")}
          project -> project
        end
    end

    case Project.insert_or_update_projects(project, params) do
      {:ok, project} ->
        conn
        |> put_status(:ok)
        |> render("show.json", project: project)

      {:error, %{errors: errors}} ->
        conn
        |> put_status(422)
        |> put_view(SapanboonWeb.ErrorView)
        |> render("422.json", errors)
    end

  end

  def delete(conn, %{"projectId" => projectId}) do
    case Project.get_projects_by_project_id(projectId) do
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
