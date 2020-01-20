defmodule Sapanboon.Histories.History do
  use Ecto.Schema
  import Ecto.Changeset

  schema "histories" do
    field :project_id, :string
    field :trans_id, :string
    field :trans_date, :utc_datetime
    field :code, :string
    field :title, :string
    field :donation, :integer
    field :status, :string
    field :email, :string
    field :image_slip, :string

    timestamps()
  end

  @doc false
  def changeset(history, attrs) do
    history
    |> cast(attrs, [:project_id, :trans_id, :trans_date, :code, :title, :donation, :status, :email, :image_slip])
    |> validate_required([:project_id, :trans_id, :trans_date, :code, :title, :donation, :status, :email, :image_slip])
  end
end
