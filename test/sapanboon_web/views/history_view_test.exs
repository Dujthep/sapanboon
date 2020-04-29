defmodule SapanboonWeb.HistoryViewTest do
  use SapanboonWeb.ConnCase, async: true
  alias SapanboonWeb.HistoryView
  import Phoenix.View

  test "renders show.json" do
    expected = %{data: %{
      status: "successfully",
      code: 1,
      name: "some name",
      email: "some email",
      transId: "some transId"
    }}
    history = %{history: %{
      code: 1,
      name: "some name",
      email: "some email",
      transId: "some transId"
    }}
    assert render(HistoryView, "show.json", history) == expected
  end

  test "renders page.json" do
    expected = %{
      status: "successfully",
      code: 1,
      name: "some name",
      email: "some email",
      transId: "some transId"
    }
    history = %{history: %{
      code: 1,
      name: "some name",
      email: "some email",
      transId: "some transId"
    }}
    assert render(HistoryView, "page.json", history) == expected
  end

end