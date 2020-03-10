defmodule SapanboonWeb.CrontabController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project
  alias Sapanboon.Project.Projects
  alias Sapanboon.Histories
  alias Sapanboon.Histories.History

  def pending(conn, _params) do
    crontab = Project.update_pending_project()
    render(conn, "show.json", crontab: crontab)
  end

  def complete(conn, _params) do
    crontab = Project.update_complete_project()
    IO.inspect(crontab)
    render(conn, "show.json", crontab: crontab)
  end

end