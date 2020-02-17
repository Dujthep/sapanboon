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
      status: "success",
      code: project.code,
      title: project.title
    }
  end

  def render("load_more.json", %{list: list}) do
    %{data: render_many(list, SapanboonWeb.Api.ProjectView, "load_more.json")}
  end

end
