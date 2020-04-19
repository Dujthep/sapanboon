defmodule Sapanboon.Project do
  @moduledoc """
  The Project context.
  """

  import Ecto.Query, warn: false

  alias Sapanboon.Repo
  alias Sapanboon.Project.Projects
  alias Sapanboon.Histories.History

  require Logger

  def count_project(status) do
    cond do
      status == nil or status == "" ->
        Projects
          |> where([p], p.projectStatus == "active")
          |> Repo.aggregate(:count, :projectStatus)
      status == "all" ->
        Projects
          |> where([p], p.projectStatus != "inactive")
          |> Repo.aggregate(:count, :projectStatus)
      status == "complete" ->
        Projects
          |> where([p], p.projectStatus == "complete" or p.projectStatus == "expire")
          |> Repo.aggregate(:count, :projectStatus)
    end
  end

  def quiry_project(sql_status, page) do
    Projects
      |> join(:left, [p], h in History,
        on: p.projectId == h.projectId and h.status == "approved"
      )
      |> where(^sql_status)
      |> limit(6)
      |> offset((^page - 1) * 6)
      |> select([p, h], %{
        id: p.id,
        projectId: p.projectId,
        name: p.name,
        code: p.code,
        introduce: p.introduce,
        dateFrom: p.dateFrom,
        dateTo: p.dateTo,
        budget: p.budget,
        projectStatus: p.projectStatus,
        donation: p.donation,
        images: p.images3,
        donation: sum(coalesce(h.amount, 0)),
        donator: count(h)
      })
      |> group_by([p], [
        p.projectId,
        p.name,
        p.code,
        p.introduce,
        p.dateFrom,
        p.dateTo,
        p.budget,
        p.projectStatus,
        p.donation,
        p.id,
        p.images3
      ])
      |> order_by([p], asc: p.code)
      |> Repo.all()
  end

  def list_project_by_status(status, page) do
    cond do
      status == nil or status == "" -> quiry_project(dynamic([p], p.projectStatus == "active"), page)
      status == "all" -> quiry_project(dynamic([p], p.projectStatus != "inactive"), page)
      status == "complete" -> quiry_project(dynamic([p], p.projectStatus == "complete" or p.projectStatus == "expire"), page)
    end
  end

  def search_project(param) do
    like = "%#{param}%"

    code = String.upcase(like)
            |> String.trim()
            |> String.replace("SPB", "")
            |> String.replace("%", "")
    code = if Regex.match?(~r{\A\d*\z}, code) do code else 0 end

    Projects
      |> join(:left, [p], h in History, on: p.projectId == h.projectId and h.status == "approved")
      |> where([p], p.projectStatus != "inactive")
      |> where([p], p.code == ^code or like(fragment("lower(?)", p.name), ^like))
      |> select([p, h], %{
        id: p.id,
        projectId: p.projectId,
        name: p.name,
        code: p.code,
        introduce: p.introduce,
        dateFrom: p.dateFrom,
        dateTo: p.dateTo,
        budget: p.budget,
        projectStatus: p.projectStatus,
        donation: p.donation,
        images: p.images3,
        donation: sum(coalesce(h.amount, 0)),
        donator: count(h)
      })
      |> group_by([p], [
        p.projectId,
        p.name,
        p.code,
        p.introduce,
        p.dateFrom,
        p.dateTo,
        p.budget,
        p.projectStatus,
        p.donation,
        p.id,
        p.images3
      ])
      |> order_by([p], asc: p.code)
      |> Repo.all()
  end

  def get_projects!(id), do: Repo.get!(Projects, id)

  def get_projects_detail(id) do
    Projects
    |> join(:left, [p], h in History, on: p.projectId == h.projectId and h.status == "approved")
    |> where([p], p.id == ^id)
    |> select([p, h], %{
      id: p.id,
      projectId: p.projectId,
      name: p.name,
      code: p.code,
      location: p.location,
      introduce: p.introduce,
      dateFrom: p.dateFrom,
      dateTo: p.dateTo,
      budget: p.budget,
      donation: p.donation,
      projectStatus: p.projectStatus,
      overview: p.overview,
      images1: p.images1,
      images2: p.images2,
      images3: p.images3,
      images4: p.images4,
      images5: p.images5,
      projectSteps1: p.projectSteps1,
      projectSteps2: p.projectSteps2,
      projectSteps3: p.projectSteps3,
      projectSteps4: p.projectSteps4,
      projectSteps5: p.projectSteps5,
      benefits1: p.benefits1,
      benefits2: p.benefits2,
      benefits3: p.benefits3,
      benefits4: p.benefits4,
      benefits5: p.benefits5,
      members1: p.members1,
      members2: p.members2,
      members3: p.members3,
      members4: p.members4,
      members5: p.members5,
      donation: sum(coalesce(h.amount, 0)),
      donator: count(h)
    })
    |> group_by([p], [
      p.id,
      p.projectId,
      p.name,
      p.code,
      p.location,
      p.introduce,
      p.dateFrom,
      p.dateTo,
      p.budget,
      p.donation,
      p.projectStatus,
      p.overview,
      p.images1,
      p.images2,
      p.images3,
      p.images4,
      p.images5,
      p.projectSteps1,
      p.projectSteps2,
      p.projectSteps3,
      p.projectSteps4,
      p.projectSteps5,
      p.benefits1,
      p.benefits2,
      p.benefits3,
      p.benefits4,
      p.benefits5,
      p.members1,
      p.members2,
      p.members3,
      p.members4,
      p.members5
    ])
    |> Repo.one()
  end

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
