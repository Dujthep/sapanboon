defmodule SapanboonWeb.Api.ProjectController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project

  def index(conn, _params) do
    list_project = list_project = Project.list_project()
    render(conn, "index.json", list_project: list_project)
  end

  def show(conn, %{"id" => id}) do
    project = Project.get_projects!(id)
    render(conn, "show.json", project: project)
  end

  def create(conn, %{"params" => params}) do
    case Project.create_project(params) do
      {:ok, res} ->
        conn
        |> Conn.put_status(200)
        |> render("show.json", res: res)

      {:error, %{errors: errors}} ->
        conn
        |> put_status(422)
        |> render(ErrorView, "422.json", %{errors: errors})
    end
  end

  def update(conn, %{"id" => id, "params" => params}) do
    project = Project.get_projects!(id)
    case Project.update_projects(project, params) do
      {:ok, res} ->
        conn
        |> Conn.put_status(200)
        |> render("show.json", res: res)

      {:error, %{errors: errors}} ->
        conn
        |> put_status(422)
        |> render(ErrorView, "422.json", %{errors: errors})
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Project.get_projects!(id)
    {:ok, _res} = Project.delete_projects(project)
    conn
      |> Conn.put_status(200)
      |> Conn.send_resp(:no_content, "")
  end

end