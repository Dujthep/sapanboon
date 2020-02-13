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

  def list_project_by_status(status) do
    if status == nil or status == "" do
      Projects
      |> limit(6)
      |> Repo.all()
    else
      Projects
        |> where([p], p.status == ^status)
        |> limit(6)
        |> Repo.all()
    end
  end

  def get_projects!(id), do: Repo.get!(Projects, id)

  def get_projects_by_project_id!(project_id), do: Repo.get_by!(Projects, project_id)

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
