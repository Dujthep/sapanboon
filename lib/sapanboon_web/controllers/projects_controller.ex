defmodule SapanboonWeb.ProjectsController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project
  alias Sapanboon.Project.Projects

  def index(conn, _params) do
    project = Project.list_project()
    render(conn, "index.html", project: project)
  end

  def new(conn, _params) do
    changeset = Project.change_projects(%Projects{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"projects" => projects_params}) do
    case Project.create_projects(projects_params) do
      {:ok, projects} ->
        conn
        |> put_flash(:info, "Projects created successfully.")
        |> redirect(to: Routes.projects_path(conn, :show, projects))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    projects = Project.get_projects!(id)
    render(conn, "show.html", projects: projects)
  end

  def edit(conn, %{"id" => id}) do
    projects = Project.get_projects!(id)
    changeset = Project.change_projects(projects)
    render(conn, "edit.html", projects: projects, changeset: changeset)
  end

  def update(conn, %{"id" => id, "projects" => projects_params}) do
    projects = Project.get_projects!(id)

    case Project.update_projects(projects, projects_params) do
      {:ok, projects} ->
        conn
        |> put_flash(:info, "Projects updated successfully.")
        |> redirect(to: Routes.projects_path(conn, :show, projects))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", projects: projects, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    projects = Project.get_projects!(id)
    {:ok, _projects} = Project.delete_projects(projects)

    conn
    |> put_flash(:info, "Projects deleted successfully.")
    |> redirect(to: Routes.projects_path(conn, :index))
  end
end
