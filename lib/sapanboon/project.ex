defmodule Sapanboon.Project do
  @moduledoc """
  The Project context.
  """

  import Ecto.Query, warn: false

  alias Sapanboon.Repo
  alias Sapanboon.Project.Projects

  def list_project do
    Repo.all(Projects)
  end

  def list_project_by_status(status, page) do

    # status = if status == nil or status == "", do: "active", else: status
    # query = from u in Sapanboon.Project.Projects,
    #       where: u.status == ^status
    # Repo.paginate(query, cursor_fields: [:inserted_at, :id], limit: 6).entries
    # IO.inspect(entries)
    # Repo.all(query);
    if status == nil or status == "" do
      Projects
      |> limit(6)
      |>  offset((^page - 1) * 6)
      |> Repo.all()
    else
      Projects
        |> where([p], p.projectStatus == ^status)
        |> limit(6)
        |>  offset((^page - 1) * 6)
        |> Repo.all()
    end
  end

  def get_projects!(id), do: Repo.get!(Projects, id)

  def get_projects_by_project_id(projectId), do: Repo.get_by(Projects, projectId: projectId)

  def create_projects(attrs \\ %{}) do
    %Projects{}
    |> Projects.changeset(attrs)
    |> Repo.insert()
  end

  def update_projects(%Projects{} = projects, attrs) do
    projects
    |> Projects.changeset(attrs)
    |> Repo.update()
  end

  def delete_projects(%Projects{} = projects) do
    Repo.delete(projects)
  end

  def change_projects(%Projects{} = projects) do
    Projects.changeset(projects, %{})
  end
end
