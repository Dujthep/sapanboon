defmodule Sapanboon.Histories.History do
  use Ecto.Schema
  import Ecto.Changeset

  schema "histories" do
    field :projectId, :string
    field :code, :integer
    field :name, :string
    field :email, :string
    field :transId, :string
    field :transDate, :utc_datetime
    field :transNo, :string
    field :amount, :integer
    field :status, :string
    field :imageSlip, :string
    field :paymentType, :string
    field :fullName, :string

    timestamps()
  end

  @doc false
  def changeset(history, attrs) do
    history
    |> cast(attrs, [:projectId, :code, :name, :email, :transId, :transDate, :transNo, :amount, :status, :imageSlip, :paymentType, :fullName])
    # |> validate_required([:projectId, :code, :name, :email, :transId, :transDate, :transNo, :amount, :status, :imageSlip, :paymentType, :fullName])
  end
end
