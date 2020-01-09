defmodule Sapanboon.Repo.Migrations.AlterProject do
  use Ecto.Migration

  def change do
    alter table(:project) do
      add :location, :string
      add :overView,  :string
      add :projectSteps, :string
      add :projectBenefits, :string
      add :projectMembers, :string
      add :img_logo,  :string
      add :img_card,  :string
      add :lmg_detail_1, :string
      add :lmg_detail_2, :string
      add :lmg_detail_3, :string
    end
  end
end
