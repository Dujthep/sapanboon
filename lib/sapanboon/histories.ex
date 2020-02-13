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

  def list_histories_by_email() do
    History
      |> where([h], h.email == "sothon@odds.team")
      |> Repo.all()
  end

  def cancel_trans(%History{} = history, attrs) do
    history
    |> History.changeset(attrs)
    |> Repo.update()
  end

  def create_trans(attrs \\ %{}) do
    %Projects{}
    |> History.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a single history.

  Raises `Ecto.NoResultsError` if the History does not exist.

  ## Examples

      iex> get_history!(123)
      %History{}

      iex> get_history!(456)
      ** (Ecto.NoResultsError)

  """
  def get_history!(id), do: Repo.get!(History, id)

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
end
