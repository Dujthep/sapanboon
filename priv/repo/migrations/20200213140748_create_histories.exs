defmodule Sapanboon.Repo.Migrations.CreateHistories do
  use Ecto.Migration

  def change do
    create table(:histories) do
      add :project_id, :string
      add :code, :string
      add :name, :string
      add :email, :string
      add :trans_id, :string
      add :trans_date, :utc_datetime
      add :trans_no, :string
      add :amount, :integer
      add :status, :string
      add :image_slip, :string
      add :payment_type, :string
      add :full_name, :string

      timestamps()
    end
  end
end
