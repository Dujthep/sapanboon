defmodule Sapanboon.Repo.Migrations.CreateProjectDetail do
  use Ecto.Migration

  def change do
    create table(:project_detail) do
      add :name, :string
      add :project_id, :string

      timestamps()
    end

  end
end
