defmodule SapanboonWeb.ProjectsView do
  use SapanboonWeb, :view
  import SapanboonWeb.ShareHelper

  require Logger

  def render("show.json", %{projects: projects}) do
    %{data: render_one(projects, SapanboonWeb.ProjectsView, "page.json")}
  end

  def render("page.json", %{projects: projects}) do
    %{
      status: "successfully",
      code: projects.code,
      name: projects.name
    }
  end

  def active_class(conn, path) do
    if conn.params["status"] == path,
      do: "nav-link text-large active",
      else: "nav-link text-large"
  end

  def calculate_percent(donation, budget) do
    if donation != nil do
      percent = donation / budget * 100
      if percent < 1, do: 1 |> round , else: percent |> round
    end
  end

  def calculate_date(dateFrom,dateTo) do
    if (dateFrom != nil and dateTo != nil) do
      day = Kernel.trunc((((DateTime.diff(dateFrom, dateTo)/60)/60)/24))
      if (day > 0) do format_number(day) else "-" end
    end
  end

  def check_more(count, project) do
    Logger.info("Deleting count: #{inspect(count)}")
    Logger.info("Deleting count: #{inspect(length(project))}")
    if count > length(project) do true else false end
  end

end
