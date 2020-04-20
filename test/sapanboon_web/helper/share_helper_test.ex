defmodule SapanboonWeb.ShareHelperTest do
  use SapanboonWeb.ConnCase
  alias SapanboonWeb.ShareHelper

  test "format_number by 10000000 return 10,000,000" do
    assert ShareHelper.format_number(10000000) == "10,000,000"
  end

  test "get_date_thai by 2020-10-15 return 15 ต.ค. 2563" do
    date = ~D[2020-10-15]
    assert ShareHelper.get_date_thai(date) == "15 ต.ค. 2563"
  end

  test "get_code by 1 return SPB1" do
    assert ShareHelper.get_code(1) == "SPB1"
  end

end