defmodule SapanboonWeb.CrontabController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project
  alias Sapanboon.Project.Projects
  alias Sapanboon.Histories
  alias Sapanboon.Histories.History

  require Logger

  def pending(conn, _params) do
    crontab = Project.update_pending_project()
    render(conn, "show.json", crontab: crontab)
  end

  def complete(conn, _params) do
    projects = Project.update_complete_project()
    Enum.each projects, fn project ->
      projectId = Project.get_projects_by_project_id(project.projectId)
      params = %{projectStatus: "complete"}
      case Project.update_projects(projectId, params) do
        {:ok, projects} ->
          Logger.info "update status projectId: #{inspect(project.projectId)} success"
        {:error, %{errors: errors}} ->
          conn
          |> put_status(422)
          |> put_view(SapanboonWeb.ErrorView)
          |> render("422.json", errors)
      end
    end
    conn
    |> put_status(200)
    |> put_view(SapanboonWeb.ProjectsView)
    |> render("update_status.json")
  end

end