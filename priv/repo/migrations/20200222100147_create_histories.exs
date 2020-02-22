defmodule Sapanboon.Repo.Migrations.CreateHistories do
  use Ecto.Migration

  def change do
    create table(:histories) do
      add :projectId, :string
      add :code, :integer
      add :name, :string
      add :email, :string
      add :transId, :string
      add :transDate, :utc_datetime
      add :transNo, :string
      add :amount, :integer
      add :status, :string
      add :imageSlip, :string
      add :paymentType, :string
      add :fullName, :string

      timestamps()
    end
  end
end
