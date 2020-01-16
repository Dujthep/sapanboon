defmodule Sapanboon.Histories.History do
  use Ecto.Schema
  import Ecto.Changeset

  schema "histories" do
    field :code, :string
    field :donation, :integer
    field :project_id, :string
    field :status, :string
    field :title, :string
    field :trans_date, :utc_datetime
    field :trans_id, :string

    timestamps()
  end

  @doc false
  def changeset(history, attrs) do
    history
    |> cast(attrs, [:project_id, :trans_id, :trans_date, :code, :title, :donation, :status])
    |> validate_required([:project_id, :trans_id, :trans_date, :code, :title, :donation, :status])
  end
end
