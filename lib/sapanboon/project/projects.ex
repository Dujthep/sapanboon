defmodule Sapanboon.Project.Projects do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only:
    [
      :projectId, :name, :code, :taxId, :projectOwner, :dateFrom,
      :dateTo, :location, :budget, :introduce, :overview, :email,
      :facebook,  :instagram, :twitter, :website, :line,  :projectSteps1,
      :projectSteps2, :projectSteps3, :projectSteps4, :projectSteps5,
      :members1, :members2, :members3, :members4, :members5, :benefits1, :benefits2,
      :benefits3, :benefits4, :benefits5, :images1, :images2, :images3, :images4,
      :images5, :projectStatus, :donation
    ]
  }
  schema "project" do
    field :projectId, :string
    field :name, :string
    field :code, :integer
    field :taxId, :string
    field :projectOwner, :string
    field :dateFrom, :utc_datetime
    field :dateTo, :utc_datetime
    field :location, :string
    field :budget, :integer
    field :introduce, :string
    field :overview, :string
    field :email, :string
    field :facebook,  :string
    field :instagram, :string
    field :twitter, :string
    field :website, :string
    field :line,  :string
    field :projectSteps1, :string
    field :projectSteps2, :string
    field :projectSteps3, :string
    field :projectSteps4, :string
    field :projectSteps5, :string
    field :members1, :string
    field :members2, :string
    field :members3, :string
    field :members4, :string
    field :members5, :string
    field :benefits1, :string
    field :benefits2, :string
    field :benefits3, :string
    field :benefits4, :string
    field :benefits5, :string
    field :images1, :string
    field :images2, :string
    field :images3, :string
    field :images4, :string
    field :images5, :string
    field :projectStatus, :string
    field :donation, :integer

    timestamps()
  end

  @doc false
  def changeset(projects, attrs) do
    projects
    |> cast(attrs, [:projectId, :name, :code, :taxId, :projectOwner, :dateFrom, :dateTo, :location, :budget, :introduce, :overview, :email, :facebook,  :instagram, :twitter, :website, :line,  :projectSteps1, :projectSteps2, :projectSteps3, :projectSteps4, :projectSteps5, :members1, :members2, :members3, :members4, :members5, :benefits1, :benefits2, :benefits3, :benefits4, :benefits5, :images1, :images2, :images3, :images4, :images5, :projectStatus, :donation])
    |> validate_required([:code, :name])
  end
end
