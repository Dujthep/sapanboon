defmodule Sapanboon.HistoriesTest do
  use Sapanboon.DataCase

  alias Sapanboon.Histories

  describe "histories" do
    alias Sapanboon.Histories.History

    @valid_attrs %{projectId: "some projectId", code: 1, name: "some name", email: "some email", transId: "some transId", transactionDate: "2011-05-18T15:01:01Z", transactionNo: 1, amount: 1, status: "some status", imgSlip: "some imgSlip", paymentType: "some paymentType", fullName: "some fullName"}
    @update_attrs %{projectId: "some projectId", code: 1, name: "some name", email: "some email", transId: "some transId", transactionDate: "2011-05-18T15:01:01Z", transactionNo: 1, amount: 1, status: "some status", imgSlip: "some imgSlip", paymentType: "some paymentType", fullName: "some fullName"}
    # @invalid_attrs %{projectId: nil, donation: nil, project_id: nil, status: nil, title: nil, transactionDate: nil, trans_id: nil}

    def history_fixture(attrs \\ %{}) do
      {:ok, history} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Histories.create_history()

      history
    end

    test "get_history!/1 returns the history with given id" do
      history = history_fixture()
      assert Histories.get_history!(history.id) == history
    end

    test "get_history_by_trans_id/1 returns the history with given trans_id" do
      history = history_fixture()
      assert Histories.get_history_by_trans_id(history.transId) == history
    end

    test "get_history_list_by_email/1 returns the history with given email" do
      history = history_fixture()
      assert Histories.get_history_list_by_email(history.email) == [history]
    end

    test "create_history/1 with valid data creates a history" do
      assert {:ok, %History{} = history} = Histories.create_history(@valid_attrs)
      assert history.projectId == "some projectId"
      assert history.code == 1
      assert history.name == "some name"
      assert history.email == "some email"
      assert history.transId == "some transId"
      assert history.transactionDate == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert history.transactionNo == 1
      assert history.amount == 1
      assert history.status == "some status"
      assert history.imgSlip == "some imgSlip"
      assert history.paymentType == "some paymentType"
      assert history.fullName == "some fullName"
    end

    test "update_history/2 with valid data updates the history" do
      history = history_fixture()
      assert {:ok, %History{} = history} = Histories.update_history(history, @update_attrs)
      assert history.projectId == "some projectId"
      assert history.code == 1
      assert history.name == "some name"
      assert history.email == "some email"
      assert history.transId == "some transId"
      assert history.transactionDate == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert history.transactionNo == 1
      assert history.amount == 1
      assert history.status == "some status"
      assert history.imgSlip == "some imgSlip"
      assert history.paymentType == "some paymentType"
      assert history.fullName == "some fullName"
    end

  end
end
