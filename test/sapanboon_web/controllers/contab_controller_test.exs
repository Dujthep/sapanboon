defmodule SapanboonWeb.ContabControllerTest do
  use SapanboonWeb.ConnCase

  describe "crontab" do

    test "Update by projectStatus is pending gives a 200 response", %{conn: conn} do
      params = %{projectId: "5d274a30403c12000113676c", projectStatus: "pending"}
      response = conn
            |> put(Routes.crontab_path(conn, :update, params))
            |> json_response(200)
      expected = %{
        "data" => %{
          "code" => 4,
          "status" => "successfully",
          "title" => "โครงการปล่อยปลาดุกหน้าเขียง วันที่ 1 มีนาคม 2563"
          }
        }
      assert response == expected
    end

    test "Update when projectId not found gives a 404 response", %{conn: conn} do
      params = %{projectId: "mock projectId", projectStatus: "mock pending"}
      response = conn
            |> put(Routes.crontab_path(conn, :update, params))
            |> json_response(404)

      expected = %{"errors" => %{"message" => "Page not found"}}
      assert response == expected
    end

  end

end
