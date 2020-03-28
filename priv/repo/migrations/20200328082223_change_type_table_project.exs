defmodule Sapanboon.Repo.Migrations.ChangeTypeTableProject do
  use Ecto.Migration

  def change do
    alter table(:project) do
      modify :projectId, :text
      modify :name, :text
      modify :code, :integer
      modify :taxId, :text
      modify :projectOwner, :text
      modify :dateFrom, :utc_datetime
      modify :dateTo, :utc_datetime
      modify :location, :text
      modify :budget, :integer
      modify :introduce, :text
      modify :overview, :text
      modify :email, :text
      modify :facebook,  :text
      modify :instagram, :text
      modify :twitter, :text
      modify :website, :text
      modify :line,  :text
      modify :projectSteps1, :text
      modify :projectSteps2, :text
      modify :projectSteps3, :text
      modify :projectSteps4, :text
      modify :projectSteps5, :text
      modify :members1, :text
      modify :members2, :text
      modify :members3, :text
      modify :members4, :text
      modify :members5, :text
      modify :benefits1, :text
      modify :benefits2, :text
      modify :benefits3, :text
      modify :benefits4, :text
      modify :benefits5, :text
      modify :images1, :text
      modify :images2, :text
      modify :images3, :text
      modify :images4, :text
      modify :images5, :text
      modify :images6, :text
      modify :projectStatus, :text
      modify :donation, :integer
    end
  end
end
