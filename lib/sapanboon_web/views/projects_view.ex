defmodule SapanboonWeb.ProjectsView do
  use SapanboonWeb, :view

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

  def format_number(number) do
    number
    |> to_string
    |> String.replace(~r/\d+(?=\.)|\A\d+\z/, fn int ->
      int
      |> String.graphemes()
      |> Enum.reverse()
      |> Enum.chunk_every(3, 3, [])
      |> Enum.join(",")
      |> String.reverse()
    end)
  end

  def calculate_percent(donation, budget) do
    if donation != nil do
      percent = donation / budget * 100
      if percent < 1, do: 1, else: percent
    else
      percent = 0
    end

  end
end
