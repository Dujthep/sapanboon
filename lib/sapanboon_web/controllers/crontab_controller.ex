defmodule SapanboonWeb.CrontabController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project

  require Logger

  def update(conn, params) do
    update = %{projectStatus: Map.get(params, "projectStatus")}
    case Project.find_by_project_id_and_update_projects(Map.get(params, "projectId"), update) do
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