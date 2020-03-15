defmodule SapanboonWeb.HistoryView do
  use SapanboonWeb, :view
  import SapanboonWeb.ShareHelper

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

  def get_code(code) do
    "SPB" <> Integer.to_string(code)
  end

  def get_date_thai(date) do
    month = ["ม.ค.","ก.พ.","มี.ค.","เม.ย.","พ.ค.","มิ.ย.","ก.ค.","ส.ค.","ก.ย.","ต.ค.","พ.ย.","ธ.ค."]
    "#{date.day}"<>" "<>Enum.at(month, date.month - 1)<>" "<>"#{date.year+ 543}"
  end
end
