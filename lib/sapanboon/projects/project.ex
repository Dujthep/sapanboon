defmodule Sapanboon.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project" do
    field :a, :integer

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:a, :b])
    |> validate_required([:a])
  end
end
