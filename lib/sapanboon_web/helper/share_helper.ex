defmodule SapanboonWeb.ShareHelper do
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

  def get_date_thai(date) do
    month = ["ม.ค.","ก.พ.","มี.ค.","เม.ย.","พ.ค.","มิ.ย.","ก.ค.","ส.ค.","ก.ย.","ต.ค.","พ.ย.","ธ.ค."]
    "#{date.day}"<>" "<>Enum.at(month, date.month - 1)<>" "<>"#{date.year+ 543}"
  end

  def get_code(code) do
    "SPB" <> Integer.to_string(code)
  end

end
