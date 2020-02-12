defmodule SapanboonWeb.Api.ProjectView do
  use SapanboonWeb, :view

  def render("index.json", %{list_project: list_project}) do
    %{data: render_many(list_project, SapanboonWeb.Api.ProjectView, "page.json")}
  end

  def render("page.json", %{project: project}) do
    %{title: project.title}
  end

end