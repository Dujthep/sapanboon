defmodule Sapanboon.Repo.Migrations.CreateHistory do
  use Ecto.Migration

  def change do
    create table(:histories) do
      add :project_id, :string
      add :trans_id, :string
      add :trans_date, :utc_datetime
      add :code, :string
      add :title, :string
      add :donation, :integer
      add :status, :string
      add :email, :string
      add :image_slip, :string

      timestamps()
    end
  end
end