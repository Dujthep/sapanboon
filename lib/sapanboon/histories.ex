defmodule Sapanboon.Histories do
  @moduledoc """
  The Histories context.
  """

  import Ecto.Query, warn: false
  alias Sapanboon.Repo

  alias Sapanboon.Histories.History

  def list_histories do
    Repo.all(History)
  end

  def list_histories_by_projectId() do
    History
      |> where([h], h.projectId == "5d274d08403c12000113676d")
      |> Repo.all()
  end

  def cancel_trans(%History{} = history, attrs) do
    history
    |> History.changeset(attrs)
    |> Repo.update()
  end

  def get_history!(id), do: Repo.get!(History, id)

  def get_history_by_trans_id(transId), do: Repo.get_by(History, transId: transId)

  def get_history_by_email(email), do: Repo.get_by(History, email: email)

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

  def delete_history(%History{} = history) do
    Repo.delete(history)
  end

  def change_history(%History{} = history) do
    History.changeset(history, %{})
  end

  def sum_history(id) do
    Repo.one(from h in History, where: h.projectId == ^id , select: sum(h.amount))
  end
end
