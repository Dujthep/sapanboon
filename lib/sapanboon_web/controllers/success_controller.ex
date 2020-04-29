defmodule SapanboonWeb.SuccessController do
  use SapanboonWeb, :controller

  alias Sapanboon.Histories
  alias Sapanboon.Project

  def index(conn,  %{"transId" => transId}) do
    history = Histories.get_history_by_trans_id(transId)
    project = Project.get_projects_by_project_id(history.projectId)
    attrs_list = [
      %{name: "og:description", content: project.introduce},
      %{property: "og:image", content: project.images2},
      %{name: "og:title", content: project.name}
    ]
    render(conn, "index.html", history: history, meta_attrs: attrs_list, projects: project)
  end
end