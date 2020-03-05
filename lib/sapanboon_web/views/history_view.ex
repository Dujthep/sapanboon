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
end
