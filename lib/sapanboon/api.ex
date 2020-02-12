defmodule Sapanboon.Api do
  import Ecto.Query, warn: false
  alias Sapanboon.Repo

  alias Sapanboon.Project.Projects

  def list_project do
    Repo.all(Projects)
  end
end