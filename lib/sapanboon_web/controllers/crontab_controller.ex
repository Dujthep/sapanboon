defmodule SapanboonWeb.CrontabController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project
  alias Sapanboon.Project.Projects
  alias Sapanboon.Histories
  alias Sapanboon.Histories.History

  require Logger

  def update(conn, params) do
    case Project.get_projects_by_project_id(Map.get(params, "projectId")) do
      projects ->
        case projects do
          nil -> conn
            |> put_status(404)
            |> put_view(SapanboonWeb.ErrorView)
            |> render("404.json")
            %{} ->
              update = %{projectStatus: Map.get(params, "projectStatus")}
              case Project.update_projects(projects, update) do
                {:ok, projects} ->
                  conn
                  |> put_status(:ok)
                  |> put_view(SapanboonWeb.ProjectsView)
                  |> render("show.json", projects: projects)

                {:error, %{errors: errors}} ->
                  conn
                  |> put_status(422)
                  |> put_view(SapanboonWeb.ErrorView)
                  |> render("422.json", errors)
              end
        end
    end
  end

end