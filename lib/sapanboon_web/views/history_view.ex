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
      name: history.name,
      email: history.email,
      transId: history.transId
    }
  end

end
