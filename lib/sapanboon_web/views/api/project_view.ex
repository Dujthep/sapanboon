defmodule SapanboonWeb.Api.ProjectView do
  use SapanboonWeb, :view

  def render("index.json", %{list_project: list_project}) do
    %{data: render_many(list_project, SapanboonWeb.Api.ProjectView, "page.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project, SapanboonWeb.Api.ProjectView, "page.json")}
  end

  def render("page.json", %{project: project}) do
    %{
      id: project.id,
      title: project.title
    }
  end

end