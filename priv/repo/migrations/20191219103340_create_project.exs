defmodule Sapanboon.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:project) do
      add :name, :string

      timestamps()
    end

  end
end
