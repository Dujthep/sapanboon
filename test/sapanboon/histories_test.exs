# defmodule Sapanboon.HistoriesTest do
#   use Sapanboon.DataCase

#   alias Sapanboon.Histories

#   describe "histories" do
#     alias Sapanboon.Histories.History

#     @valid_attrs %{code: "some code", donation: 42, project_id: "some project_id", status: "some status", title: "some title", transDate: "2010-04-17T14:00:00Z", trans_id: "some trans_id"}
#     @update_attrs %{code: "some updated code", donation: 43, project_id: "some updated project_id", status: "some updated status", title: "some updated title", transDate: "2011-05-18T15:01:01Z", trans_id: "some updated trans_id"}
#     @invalid_attrs %{code: nil, donation: nil, project_id: nil, status: nil, title: nil, transDate: nil, trans_id: nil}

#     def history_fixture(attrs \\ %{}) do
#       {:ok, history} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Histories.create_history()

#       history
#     end

#     test "list_histories/0 returns all histories" do
#       history = history_fixture()
#       assert Histories.list_histories() == [history]
#     end

#     test "get_history!/1 returns the history with given id" do
#       history = history_fixture()
#       assert Histories.get_history!(history.id) == history
#     end

#     test "create_history/1 with valid data creates a history" do
#       assert {:ok, %History{} = history} = Histories.create_history(@valid_attrs)
#       assert history.code == "some code"
#       assert history.donation == 42
#       assert history.project_id == "some project_id"
#       assert history.status == "some status"
#       assert history.name == "some title"
#       assert history.transDate == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
#       assert history.trans_id == "some trans_id"
#     end

#     test "create_history/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Histories.create_history(@invalid_attrs)
#     end

#     test "update_history/2 with valid data updates the history" do
#       history = history_fixture()
#       assert {:ok, %History{} = history} = Histories.update_history(history, @update_attrs)
#       assert history.code == "some updated code"
#       assert history.donation == 43
#       assert history.project_id == "some updated project_id"
#       assert history.status == "some updated status"
#       assert history.name == "some updated title"
#       assert history.transDate == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
#       assert history.trans_id == "some updated trans_id"
#     end

#     test "update_history/2 with invalid data returns error changeset" do
#       history = history_fixture()
#       assert {:error, %Ecto.Changeset{}} = Histories.update_history(history, @invalid_attrs)
#       assert history == Histories.get_history!(history.id)
#     end

#     test "delete_history/1 deletes the history" do
#       history = history_fixture()
#       assert {:ok, %History{}} = Histories.delete_history(history)
#       assert_raise Ecto.NoResultsError, fn -> Histories.get_history!(history.id) end
#     end

#     test "change_history/1 returns a history changeset" do
#       history = history_fixture()
#       assert %Ecto.Changeset{} = Histories.change_history(history)
#     end
#   end
# end
