defmodule SapanboonWeb.ProjectsControllerTest do
  use SapanboonWeb.ConnCase
  alias Sapanboon.Project

  @valid_attrs %{
    projectId: "mock projectId",
    name: "mock name",
    code: 1,
    taxId: "mock taxId",
    projectOwner: "mock projectOwner",
    dateFrom: "2011-05-18T15:01:01Z",
    dateTo: "2011-05-18T15:01:01Z",
    location: "mock location",
    budget: 10000,
    introduce: "mock introduce",
    overview: "mock overview",
    email: "mock email",
    facebook: "mock facebook",
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
    projectStatus: "mock projectStatus",
    donation: 0
  }

  def fixture(:projects) do
    {:ok, projects} = Project.create_projects(@valid_attrs)
    projects
  end

  defp create_projects(_) do
    projects = fixture(:projects)
    {:ok, projects: projects}
  end

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
    setup [:create_projects]

    test "gives a status 200 when data is valid", %{conn: conn} do
      actual = conn
                |> post(Routes.projects_path(conn, :create, @valid_attrs))
                |> json_response(200)

      expected = %{"data" => %{"code" => 1, "name" => "mock name", "status" => "successfully"}}

      assert actual == expected
    end
  end

  describe "update project" do
    setup [:create_projects]

    test "insert when projectId is nil, response status 200", %{conn: conn} do
      params = %{projectId: nil, name: "mock name", code: 1,}
      actual = conn
                |> put(Routes.projects_path(conn, :update, params))
                |> json_response(200)

      expected = %{"data" => %{"code" => 1, "name" => "mock name", "status" => "successfully"}}

      assert actual == expected
    end

    test "update when projectId not nil", %{conn: conn} do
      actual = conn
                |> put(Routes.projects_path(conn, :update, @valid_attrs))
                |> json_response(200)

      expected = %{"data" => %{"code" => 1, "name" => "mock name", "status" => "successfully"}}

      assert actual == expected
    end

  end

  describe "search" do
    setup [:create_projects]

    test "search by 'mock name'", %{conn: conn} do
      param = %{param: "mock name"}
      [projects] = conn
              |> get(Routes.projects_path(conn, :search, param))
              |> json_response(200)

      assert projects["name"] == "mock name"
      assert projects["budget"] == 10000
      assert projects["projectId"] == "mock projectId"
    end

    test "search by 'not have result', should return emtpy list", %{conn: conn} do
      param = %{param: "not have result"}
      assert conn
          |> get(Routes.projects_path(conn, :search, param))
          |> json_response(200) == []
    end
  end

  describe "create_transaction" do
    setup [:create_projects]

    test "call create_transaction should redirect to payment path", %{conn: conn} do
      params = %{amount: 1000, fullName: "some fullName"}
      user = %Sapanboon.User{email: "mock email"}
      conn = conn
              |> assign(:user, user)
              |> get(Routes.projects_path(conn, :create_transaction, 5, params))

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.payment_path(conn, :index, id)

      conn = get(conn, Routes.payment_path(conn, :index, id))
      assert html_response(conn, 200) =~ "กรุณาแสกน QR เพื่อบริจาค"
    end
  end

end
