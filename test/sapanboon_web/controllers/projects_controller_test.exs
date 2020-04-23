defmodule SapanboonWeb.ProjectsControllerTest do
  use SapanboonWeb.ConnCase

  @valid_attrs %{
    projectId: "some projectId",
    name: "some name",
    code: 1,
    taxId: "some taxId",
    projectOwner: "some projectOwner",
    dateFrom: "2011-05-18T15:01:01Z",
    dateTo: "2011-05-18T15:01:01Z",
    location: "some location",
    budget: 10000,
    introduce: "some introduce",
    overview: "some overview",
    email: "some email",
    facebook: "some facebook",
    instagram: "instagram",
    twitter: "twitter",
    website: "website",
    line: "line",
    projectSteps1: "projectSteps1",
    projectSteps2: "projectSteps2",
    projectSteps3: "projectSteps3",
    projectSteps4: "projectSteps4",
    projectSteps5: "projectSteps5",
    members1: "members1",
    members2: "members2",
    members3: "members3",
    members4: "members4",
    members5: "members5",
    benefits1: "benefits1",
    benefits2: "benefits2",
    benefits3: "benefits3",
    benefits4: "benefits4",
    benefits5: "benefits5",
    images1: "images1",
    images2: "images2",
    images3: "images3",
    images4: "images4",
    images5: "images5",
    projectStatus: "projectStatus",
    donation: 0
  }
  #   @create_attrs %{code: "some code", cover: "some cover", introduce: "some introduce", donation: 42, donator: 42, dateTo: "2010-04-17T14:00:00Z", budget: 42, project_id: "some project_id", start_date: "2010-04-17T14:00:00Z", status: "some status", title: "some title"}
  #   @update_attrs %{code: "some updated code", cover: "some updated cover", introduce: "some updated introduce", donation: 43, donator: 43, dateTo: "2011-05-18T15:01:01Z", budget: 43, project_id: "some updated project_id", start_date: "2011-05-18T15:01:01Z", status: "some updated status", title: "some updated title"}
  #   @invalid_attrs %{code: nil, cover: nil, introduce: nil, donation: nil, donator: nil, dateTo: nil, budget: nil, project_id: nil, start_date: nil, status: nil, title: nil}

  #   def fixture(:projects) do
  #     {:ok, projects} = Project.create_projects(@create_attrs)
  #     projects
  #   end

  describe "index" do
    test "lists all project is active", %{conn: conn} do
      conn = get(conn, Routes.projects_path(conn, :index))
      items = conn.assigns.list_project

      items =
        Enum.filter(items, fn item ->
          item.projectStatus != "active"
        end)

      assert Enum.count(items) == 0
    end
  end

  describe "detail" do
    test "get project Detail", %{conn: conn} do
      conn = get(conn, Routes.projects_path(conn, :detail, 15))
      items = conn.assigns.projects

      assert items.benefits1 =~
               "เป็นการช่วยเหลือผู้ป่วยที่ติดเชื้อเอดส์"
    end
  end

  describe "load_more" do
    test "load_more project", %{conn: conn} do
      conn = get(conn, Routes.projects_path(conn, :load_more))
      items = Poison.Parser.parse!(conn.resp_body)

      assert items["count"] == 7
    end
  end

  describe "create project" do
    test "gives a status 200 when data is valid", %{conn: conn} do
      actual = conn
                |> post(Routes.projects_path(conn, :create, @valid_attrs))
                |> json_response(200)

      expected = %{"data" => %{"code" => 1, "name" => "some name", "status" => "successfully"}}

      assert actual == expected
    end
  end

  describe "update project" do
    test "gives a status 200 when update success", %{conn: conn} do
      actual = conn
                |> put(Routes.projects_path(conn, :update, @valid_attrs))
                |> json_response(200)

      expected = %{"data" => %{"code" => 1, "name" => "some name", "status" => "successfully"}}

      assert actual == expected
    end
  end

  # describe "get Detail" do
  #   test "get Project Detail", %{conn: conn} do
  #     (conn = get(conn, Routes.projects_path(conn, :detail)))
  #     IO.inspect(conn.assgigns)
  #   end
  # end

  #   describe "new projects" do
  #     test "renders form", %{conn: conn} do
  #       conn = get(conn, Routes.projects_path(conn, :new))
  #       assert html_response(conn, 200) =~ "New Projects"
  #     end
  #   end

  #   describe "create projects" do
  #     test "redirects to show when data is valid", %{conn: conn} do
  #       conn = post(conn, Routes.projects_path(conn, :create), projects: @create_attrs)

  #       assert %{id: id} = redirected_params(conn)
  #       assert redirected_to(conn) == Routes.projects_path(conn, :show, id)

  #       conn = get(conn, Routes.projects_path(conn, :show, id))
  #       assert html_response(conn, 200) =~ "Show Projects"
  #     end

  #     test "renders errors when data is invalid", %{conn: conn} do
  #       conn = post(conn, Routes.projects_path(conn, :create), projects: @invalid_attrs)
  #       assert html_response(conn, 200) =~ "New Projects"
  #     end
  #   end

  #   describe "edit projects" do
  #     setup [:create_projects]

  #     test "renders form for editing chosen projects", %{conn: conn, projects: projects} do
  #       conn = get(conn, Routes.projects_path(conn, :edit, projects))
  #       assert html_response(conn, 200) =~ "Edit Projects"
  #     end
  #   end

  #   describe "update projects" do
  #     setup [:create_projects]

  #     test "redirects when data is valid", %{conn: conn, projects: projects} do
  #       conn = put(conn, Routes.projects_path(conn, :update, projects), projects: @update_attrs)
  #       assert redirected_to(conn) == Routes.projects_path(conn, :show, projects)

  #       conn = get(conn, Routes.projects_path(conn, :show, projects))
  #       assert html_response(conn, 200) =~ "some updated code"
  #     end

  #     test "renders errors when data is invalid", %{conn: conn, projects: projects} do
  #       conn = put(conn, Routes.projects_path(conn, :update, projects), projects: @invalid_attrs)
  #       assert html_response(conn, 200) =~ "Edit Projects"
  #     end
  #   end

  #   describe "delete projects" do
  #     setup [:create_projects]

  #     test "deletes chosen projects", %{conn: conn, projects: projects} do
  #       conn = delete(conn, Routes.projects_path(conn, :delete, projects))
  #       assert redirected_to(conn) == Routes.projects_path(conn, :index)
  #       assert_error_sent 404, fn ->
  #         get(conn, Routes.projects_path(conn, :show, projects))
  #       end
  #     end
  #   end

  #   defp create_projects(_) do
  #     projects = fixture(:projects)
  #     {:ok, projects: projects}
  #   end
end
