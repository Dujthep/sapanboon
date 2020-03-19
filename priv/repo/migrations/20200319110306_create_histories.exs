defmodule Sapanboon.Repo.Migrations.CreateHistories do
  use Ecto.Migration

  def change do
    create table(:histories) do
      add :projectId, :string
      add :code, :integer
      add :name, :string
      add :email, :string
      add :transId, :string
      add :transactionDate, :utc_datetime
      add :transactionNo, :integer
      add :amount, :integer
      add :status, :string
      add :imgSlip, :string
      add :paymentType, :string
      add :fullName, :string

      timestamps()
    end
  end
end
