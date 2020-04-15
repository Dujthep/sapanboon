defmodule Sapanboon.Histories do
  @moduledoc """
  The Histories context.
  """

  import Ecto.Query, warn: false
  alias Sapanboon.Repo

  alias Sapanboon.Histories.History

  def get_history!(id),do: Repo.get!(History, id)

  def get_history_by_trans_id(transId), do: Repo.get_by(History, transId: transId)

  def get_history_list_by_email(email) do
    History
    |> where([h], h.email == ^email)
    |> order_by([h], [desc: h.transId])
    |> Repo.all()
  end

  def create_history(attrs \\ %{}) do
    %History{}
    |> History.changeset(attrs)
    |> Repo.insert()
  end

  def update_history(%History{} = history, attrs) do
    history
    |> History.changeset(attrs)
    |> Repo.update()
  end

end
