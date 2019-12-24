defmodule Sapanboon.Project do
  @moduledoc """
  The Project context.
  """

  import Ecto.Query, warn: false
  alias Sapanboon.Repo

  alias Sapanboon.Project.Projects

  @doc """
  Returns the list of project.

  ## Examples

      iex> list_project()
      [%Projects{}, ...]

  """
  def list_project do
    Repo.all(Projects)
  end

  @doc """
  Gets a single projects.

  Raises `Ecto.NoResultsError` if the Projects does not exist.

  ## Examples

      iex> get_projects!(123)
      %Projects{}

      iex> get_projects!(456)
      ** (Ecto.NoResultsError)

  """
  def get_projects!(id), do: Repo.get!(Projects, id)

  @doc """
  Creates a projects.

  ## Examples

      iex> create_projects(%{field: value})
      {:ok, %Projects{}}

      iex> create_projects(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_projects(attrs \\ %{}) do
    %Projects{}
    |> Projects.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a projects.

  ## Examples

      iex> update_projects(projects, %{field: new_value})
      {:ok, %Projects{}}

      iex> update_projects(projects, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_projects(%Projects{} = projects, attrs) do
    projects
    |> Projects.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Projects.

  ## Examples

      iex> delete_projects(projects)
      {:ok, %Projects{}}

      iex> delete_projects(projects)
      {:error, %Ecto.Changeset{}}

  """
  def delete_projects(%Projects{} = projects) do
    Repo.delete(projects)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking projects changes.

  ## Examples

      iex> change_projects(projects)
      %Ecto.Changeset{source: %Projects{}}

  """
  def change_projects(%Projects{} = projects) do
    Projects.changeset(projects, %{})
  end

  alias Sapanboon.Project.ProjectDetail

  @doc """
  Returns the list of project_detail.

  ## Examples

      iex> list_project_detail()
      [%ProjectDetail{}, ...]

  """
  def list_project_detail do
    Repo.all(ProjectDetail)
  end

  @doc """
  Gets a single project_detail.

  Raises `Ecto.NoResultsError` if the Project detail does not exist.

  ## Examples

      iex> get_project_detail!(123)
      %ProjectDetail{}

      iex> get_project_detail!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project_detail!(id), do: Repo.get!(ProjectDetail, id)

  @doc """
  Creates a project_detail.

  ## Examples

      iex> create_project_detail(%{field: value})
      {:ok, %ProjectDetail{}}

      iex> create_project_detail(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project_detail(attrs \\ %{}) do
    %ProjectDetail{}
    |> ProjectDetail.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project_detail.

  ## Examples

      iex> update_project_detail(project_detail, %{field: new_value})
      {:ok, %ProjectDetail{}}

      iex> update_project_detail(project_detail, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project_detail(%ProjectDetail{} = project_detail, attrs) do
    project_detail
    |> ProjectDetail.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ProjectDetail.

  ## Examples

      iex> delete_project_detail(project_detail)
      {:ok, %ProjectDetail{}}

      iex> delete_project_detail(project_detail)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project_detail(%ProjectDetail{} = project_detail) do
    Repo.delete(project_detail)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project_detail changes.

  ## Examples

      iex> change_project_detail(project_detail)
      %Ecto.Changeset{source: %ProjectDetail{}}

  """
  def change_project_detail(%ProjectDetail{} = project_detail) do
    ProjectDetail.changeset(project_detail, %{})
  end
end
