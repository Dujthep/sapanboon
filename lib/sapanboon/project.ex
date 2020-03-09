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
    cond do
      status == nil or status == "" ->
        Projects
        |> where([p], p.projectStatus != "inactive")
        |> limit(6)
        |> offset((^page - 1) * 6)
        |> order_by([p], desc: p.code)
        |> Repo.all()

      status == "complete" ->
        Projects
        |> where([p], p.projectStatus == "complete")
        |> or_where([p], p.projectStatus == "expire")
        |> limit(6)
        |> offset((^page - 1) * 6)
        |> order_by([p], desc: p.code)
        |> Repo.all()

      true ->
        Projects
        |> where([p], p.projectStatus == ^status)
        |> limit(6)
        |> offset((^page - 1) * 6)
        |> order_by([p], desc: p.code)
        |> Repo.all()
    end
  end

  def update_pending_project() do
    dateTime = Calendar.DateTime.now! "Asia/Bangkok"
    Projects
      |> where([p], p.dateFrom <= ^dateTime and p.projectStatus == "pending")
      |> update([set: [projectStatus: "active"]])
      |> Repo.update_all([])
  end

  def get_project_by_param(param) do
    like = "%#{param}%"

    from(
      p in Projects,
      where: like(p.name, ^like)
    )
    |> Repo.all()
  end

  def get_projects!(id), do: Repo.get!(Projects, id)

  def get_projects_by_project_id(projectId), do: Repo.get_by(Projects, projectId: projectId)

  def create_projects(attrs \\ %{}) do
    %Projects{}
    |> Projects.changeset(attrs)
    |> Repo.insert()
  end

  def insert_or_update_projects(%Projects{} = projects, attrs) do
    projects
    |> Projects.changeset(attrs)
    |> Repo.insert_or_update()
  end

  def delete_projects(%Projects{} = projects) do
    Repo.delete(projects)
  end

  def change_projects(%Projects{} = projects) do
    Projects.changeset(projects, %{})
  end
end
