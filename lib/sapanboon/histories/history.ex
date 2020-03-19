defmodule Sapanboon.Histories.History do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only:
    [:projectId, :code, :name, :email, :transId, :transactionDate, :transactionNo, :amount, :status, :imgSlip, :paymentType, :fullName]
  }

  schema "histories" do
    field :projectId, :string
    field :code, :integer
    field :name, :string
    field :email, :string
    field :transId, :string
    field :transactionDate, :utc_datetime
    field :transactionNo, :integer
    field :amount, :integer
    field :status, :string
    field :imgSlip, :string
    field :paymentType, :string
    field :fullName, :string

    timestamps()
  end

  @doc false
  def changeset(history, attrs) do
    history
    |> cast(attrs, [:projectId, :code, :name, :email, :transId, :transactionDate, :transactionNo, :amount, :status, :imgSlip, :paymentType, :fullName])
    # |> validate_required([:projectId, :code, :name, :email, :transId, :transactionDate, :transactionNo, :amount, :status, :imgSlip, :paymentType, :fullName])
  end
end
