defmodule SapanboonWeb.ProjectsView do
  use SapanboonWeb, :view

  def format_date_time(date) do
    {date.year, date.month, date.day}
    |> Calendar.Strftime.strftime!("%A %d %B", :th)
    |> Kernel.<>(" #{date.year + 543}")
  end

  def active_class(conn, path) do 
    # IO.inspect(conn.params["status"])
    if conn.params["status"] == path, do: "nav-link text-large active", else: "nav-link text-large"
  end
end
