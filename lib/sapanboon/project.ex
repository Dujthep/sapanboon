defmodule Sapanboon.Project do
  @moduledoc """
  The Project context.
  """

  import Ecto.Query, warn: false

  alias Sapanboon.Repo
  alias Sapanboon.Project.Projects
  alias Sapanboon.Histories.History

  def list_project do
    Repo.all(Projects)
  end

  def list_project_by_status(status, page) do
    cond do
      status == nil or status == "" ->
        Projects
        |> join(:inner, [p], h in History, on: p.projectId == h.projectId and h.status == "approved")
        |> where([p], p.projectStatus != "inactive")
        |> limit(6)
        |> offset((^page - 1) * 6)
        |> select([p, h], %{id: p.id,projectId: p.projectId,name: p.name,code: p.code,
          introduce: p.introduce,dateFrom: p.dateFrom,dateTo: p.dateTo,budget: p.budget,
          donation: p.donation,images1: p.images1,total: sum(h.amount),donation: count(h)})
        |> group_by([p], [p.projectId, p.name, p.code, p.introduce, p.dateFrom, p.dateTo, p.budget, p.donation, p.id, p.images1])
        |> order_by([p], desc: p.code)
        |> Repo.all()

      status == "complete" ->
        Projects
        |> join(:inner, [p], h in History, on: p.projectId == h.projectId and h.status == "approved")
        |> where([p], p.projectStatus == "complete")
        |> or_where([p], p.projectStatus == "expire")
        |> limit(6)
        |> offset((^page - 1) * 6)
        |> select([p, h], %{id: p.id,projectId: p.projectId,name: p.name,code: p.code,
          introduce: p.introduce,dateFrom: p.dateFrom,dateTo: p.dateTo,budget: p.budget,
          donation: p.donation,images1: p.images1,total: sum(h.amount),donation: count(h)})
        |> group_by([p], [p.projectId, p.name, p.code, p.introduce, p.dateFrom, p.dateTo, p.budget, p.donation, p.id, p.images1])
        |> order_by([p], desc: p.code)
        |> Repo.all()

      true ->
        Projects
        |> join(:inner, [p], h in History, on: p.projectId == h.projectId and h.status == "approved")
        |> where([p], p.projectStatus == ^status)
        |> limit(6)
        |> offset((^page - 1) * 6)
        |> select([p, h], %{id: p.id,projectId: p.projectId,name: p.name,code: p.code,
          introduce: p.introduce,dateFrom: p.dateFrom,dateTo: p.dateTo,budget: p.budget,
          donation: p.donation,images1: p.images1,total: sum(h.amount),donation: count(h)})
        |> group_by([p], [p.projectId, p.name, p.code, p.introduce, p.dateFrom, p.dateTo, p.budget, p.donation, p.id, p.images1])
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

  def update_complete_project() do
    Projects
      |> join(:inner, [p], h in History, on: p.projectId == h.projectId)
      |> where([p], p.projectStatus == "active")
      |> group_by([p], [p.projectId, p.budget])
      |> having([p, h], sum(h.amount) >= p.budget)
      |> select([:projectId])
      |> Repo.all([])
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
