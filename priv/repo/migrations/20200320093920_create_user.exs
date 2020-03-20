defmodule Sapanboon.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :provider, :string
      add :token, :string
      add :uid, :string
      add :name, :string
      add :role, :string

      timestamps()
    end
  end
end
