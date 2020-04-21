defmodule SapanboonWeb.HistoryView do
  use SapanboonWeb, :view
  import SapanboonWeb.ShareHelper

  def render("show.json", %{history: history}) do
    %{data: render_one(history, SapanboonWeb.HistoryView, "page.json")}
  end

  def render("page.json", %{history: history}) do
    %{
      status: "successfully",
      code: history.code,
      title: history.name,
      email: history.email
    }
  end

end
