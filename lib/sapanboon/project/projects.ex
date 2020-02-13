defmodule Sapanboon.Project.Projects do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project" do
    field :code, :string
    field :cover, :string
    field :description, :string
    field :donation, :integer
    field :donator, :integer
    field :end_date, :utc_datetime
    field :pledged_goal, :integer
    field :project_id, :string
    field :start_date, :utc_datetime
    field :status, :string
    field :title, :string
    field :location, :string
    field :overView,  :string
    field :projectSteps,  :string
    field :projectBenefits, :string
    field :projectMembers,  :string
    field :img_card,  :string
    field :lmg_detail_1,  :string
    field :lmg_detail_2,  :string
    field :lmg_detail_3,  :string

    timestamps()
  end

  @doc false
  def changeset(projects, attrs) do
    projects
    |> cast(attrs, [:project_id, :code, :title, :cover, :pledged_goal, :start_date, :end_date, :description, :status, :donator, :donation])
    |> validate_required([:code, :title])
  end
end
