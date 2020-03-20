defmodule Sapanboon.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    field :uid, :string
    field :name, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :provider, :token, :uid, :name, :role])
    |> validate_required([:email, :provider, :uid, :name, :role])
  end

  def get_by!(id), do: Repo.get!(History, id)
end
