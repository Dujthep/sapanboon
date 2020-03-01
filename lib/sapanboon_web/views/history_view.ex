defmodule SapanboonWeb.HistoryView do
  use SapanboonWeb, :view

  def render("show.json", %{history: history}) do
    %{data: render_one(history, SapanboonWeb.HistoryView, "page.json")}
  end

  def render("page.json", %{history: history}) do
    %{
      status: "successfully",
      id: history.id,
      code: history.code,
      title: history.name
    }
  end
end
