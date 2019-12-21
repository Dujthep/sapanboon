defmodule Sapanboon.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:project) do
      add :project_id, :string
      add :code, :string
      add :title, :string
      add :cover, :string
      add :pledged_goal, :integer
      add :start_date, :utc_datetime
      add :end_date, :utc_datetime
      add :description, :string
      add :status, :string
      add :donator, :integer
      add :donation, :integer

      timestamps()
    end

  end
end
