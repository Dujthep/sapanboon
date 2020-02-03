defmodule Sapanboon.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
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
    |> cast(attrs, [:first_name, :last_name, :email, :provider, :token, :uid, :name, :role])
    |> validate_required([:email, :provider, :token, :uid, :name, :role])
  end

  def get_by!(id), do: Repo.get!(History, id)
end
