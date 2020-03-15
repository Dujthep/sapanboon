defmodule SapanboonWeb.ProjectsView do
  use SapanboonWeb, :view
  import SapanboonWeb.ShareHelper

  def render("show.json", %{projects: projects}) do
    %{data: render_one(projects, SapanboonWeb.ProjectsView, "page.json")}
  end

  def render("page.json", %{projects: projects}) do
    %{
      status: "successfully",
      code: projects.code,
      title: projects.name
    }
  end

  def render("update_status.json", _assigns) do
    %{
      status: "successfully",
      message: "update status success."
    }
  end

  def format_date_time(date) do
    {date.year, date.month, date.day}
    # |> Calendar.Strftime.strftime!("%A %d %B", :th)
    # |> Kernel.<>(" #{date.year + 543}")
  end

  def active_class(conn, path) do
    # IO.inspect(conn.params["status"])
    if conn.params["status"] == path,
      do: "nav-link text-large active",
      else: "nav-link text-large"
  end

  def get_code(code) do
      "SPB" <> Integer.to_string(code)
  end

  def calculate_percent(donation, budget) do
    if donation != nil do
      percent = donation / budget * 100
      if percent < 1, do: 1 |> round , else: percent |> round 
    end
  end

  def calculate_date(dateFrom,dateTo) do
    if (dateFrom != nil and dateTo != nil) do
      day = Kernel.trunc((((DateTime.diff(dateFrom, dateTo)/60)/60)/24))
      if (day > 0) do format_number(day) else 0 end 
    end
  end

  def get_date_thai(date) do
    month = ["ม.ค.","ก.พ.","มี.ค.","เม.ย.","พ.ค.","มิ.ย.","ก.ค.","ส.ค.","ก.ย.","ต.ค.","พ.ย.","ธ.ค."]
    "#{date.day}"<>" "<>Enum.at(month, date.month - 1)<>" "<>"#{date.year+ 543}"
  end
end
