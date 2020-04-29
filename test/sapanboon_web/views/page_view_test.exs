defmodule SapanboonWeb.PageViewTest do
  use SapanboonWeb.ConnCase, async: true
  alias SapanboonWeb.PageView

  test "meta_tags attrs_list, should have [description, image, title]" do
    expected = [
      {:safe, [60, "meta", [[32, "content", 61, 34, "ขอเชิญท่านผู้มีจิตศรัทธาร่วมสร้างสถานปฎิบัติธรรม", 34],
      [32, "name", 61, 34, "og:description", 34]], 62]},
      {:safe, [60, "meta", [[32, "content", 61, 34, "minio", 34],
      [32, "property", 61, 34, "og:image", 34]], 62]},
      {:safe, [60, "meta", [[32, "content", 61, 34, "สร้างสถานปฎิบัติธรรม สมเด็จพระสังฆราช (อมฺพรมหาเถร) วัดราชบพิธ", 34],
      [32, "name", 61, 34, "og:title", 34]], 62]}
    ]

    attrs_list = [
      %{name: "og:description", content: "ขอเชิญท่านผู้มีจิตศรัทธาร่วมสร้างสถานปฎิบัติธรรม"},
      %{property: "og:image", content: "minio"},
      %{name: "og:title", content: "สร้างสถานปฎิบัติธรรม สมเด็จพระสังฆราช (อมฺพรมหาเถร) วัดราชบพิธ"}
    ]
    assert PageView.meta_tags(attrs_list) == expected
  end
end
