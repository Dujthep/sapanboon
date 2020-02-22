defmodule Sapanboon.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:project) do
      add :projectId, :string
      add :name, :text
      add :code, :integer
      add :taxId, :string
      add :projectOwner, :string
      add :dateFrom, :utc_datetime
      add :dateTo, :utc_datetime
      add :location, :string
      add :budget, :integer
      add :introduce, :text
      add :overview, :text
      add :email, :string
      add :facebook,  :string
      add :instagram, :string
      add :twitter, :string
      add :website, :string
      add :line,  :string
      add :projectSteps1, :string
      add :projectSteps2, :string
      add :projectSteps3, :string
      add :projectSteps4, :string
      add :projectSteps5, :string
      add :members1, :string
      add :members2, :string
      add :members3, :string
      add :members4, :string
      add :members5, :string
      add :benefits1, :string
      add :benefits2, :string
      add :benefits3, :string
      add :benefits4, :string
      add :benefits5, :string
      add :images1, :string
      add :images2, :string
      add :images3, :string
      add :images4, :string
      add :images5, :string
      add :images6, :string
      add :projectStatus, :string
      add :donation, :integer

      timestamps()
    end

  end
end
