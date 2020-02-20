defmodule Sapanboon.Histories.History do
  use Ecto.Schema
  import Ecto.Changeset

  schema "histories" do
    field :project_id, :string
    field :code, :string
    field :name, :string
    field :email, :string
    field :trans_id, :string
    field :trans_date, :utc_datetime
    field :trans_no, :string
    field :amount, :integer
    field :status, :string
    field :image_slip, :string
    field :payment_type, :string
    field :full_name, :string

    timestamps()
  end

  @doc false
  def changeset(history, attrs) do
    history
    |> cast(attrs, [:project_id, :code, :name, :email, :trans_id, :trans_date, :trans_no, :amount, :status, :image_slip, :payment_type, :full_name])
    # |> validate_required([:project_id, :code, :name, :email, :trans_id, :trans_date, :trans_no, :amount, :status, :image_slip, :payment_type, :full_name])
  end
end
