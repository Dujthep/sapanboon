defmodule SapanboonWeb.CrontabView do
  use SapanboonWeb, :view

  def render("show.json", %{crontab: crontab}) do
    %{data: render_one(crontab, SapanboonWeb.CrontabView, "page.json")}
  end

  def render("page.json", %{crontab: crontab}) do
    %{
      status: "successfully"
    }
  end
end
