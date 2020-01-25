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

  def format_number(number) do
    number
    |> to_string
    |> String.replace(~r/\d+(?=\.)|\A\d+\z/, fn(int) ->
      int
      |> String.graphemes
      |> Enum.reverse
      |> Enum.chunk_every(3, 3, [])
      |> Enum.join(",")
      |> String.reverse
    end)
  end

  def calculate_percent(amount, budget) do
    if budget > 0 do
      percent = ((amount / budget) * 100)
      if percent < 1 && percent > 0, do: 1, else: percent
    end
  end

end
