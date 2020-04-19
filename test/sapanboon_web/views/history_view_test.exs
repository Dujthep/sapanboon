defmodule SapanboonWeb.HistoryViewTest do
  use SapanboonWeb.ConnCase, async: true
  alias SapanboonWeb.HistoryView
  import Phoenix.View

  test "renders show.json" do
    expected = %{data: %{
      status: "successfully",
      id: 1,
      code: 2,
      title: "some name"
    }}
    history = %{history: %{
      id: 1,
      code: 2,
      name: "some name"
    }}
    assert render(HistoryView, "show.json", history) == expected
  end

  test "renders page.json" do
    expected = %{
      status: "successfully",
      id: 1,
      code: 2,
      title: "some name"
    }
    history = %{history: %{
      id: 1,
      code: 2,
      name: "some name"
    }}
    assert render(HistoryView, "page.json", history) == expected
  end

end