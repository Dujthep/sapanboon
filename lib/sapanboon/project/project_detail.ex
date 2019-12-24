defmodule Sapanboon.Project.ProjectDetail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project_detail" do
    field :name, :string
    field :project_id, :string

    timestamps()
  end

  @doc false
  def changeset(project_detail, attrs) do
    project_detail
    |> cast(attrs, [:name, :project_id])
    |> validate_required([:name, :project_id])
  end
end
