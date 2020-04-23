defmodule Sapanboon.ProjectTest do
  use Sapanboon.DataCase

  alias Sapanboon.Project
  require Logger

  describe "project" do
    alias Sapanboon.Project.Projects

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

    @update_attrs %{
      projectId: "update projectId",
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

    @invalid_attrs %{code: nil, name: nil}

    def projects_fixture(attrs \\ %{}) do
      {:ok, projects} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Project.create_projects()

      projects
    end

    test "count_project where status is 'nil' return project count is projectStatus eq 'active'" do
      assert Project.count_project(nil) == 7
    end

    test "count_project where status is 'all' return project count is projectStatus not eq 'inactive'" do
      assert Project.count_project("all") == 12
    end

    test "count_project where status is 'complete' return project count is projectStatus eq 'complete' or 'expire'" do
      assert Project.count_project("complete") == 5
    end

    test "create_projects with valid data creates a projects" do
      assert {:ok, %Projects{} = projects} = Project.create_projects(@valid_attrs)
      assert projects.code == 1
      assert projects.name == "some name"
    end

    test "create_projects with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Project.create_projects(@invalid_attrs)
    end

    test "list_project_by_status where status is 'nil' return list project is projectStatus eq 'active'" do
      [p1, p2, p3, p4, p5, p6] = Project.list_project_by_status(nil, 1)
      assert p1.projectStatus == "active"
      assert p2.projectStatus == "active"
      assert p3.projectStatus == "active"
      assert p4.projectStatus == "active"
      assert p5.projectStatus == "active"
      assert p6.projectStatus == "active"
    end

    test "list_project_by_status where status is 'nil' and page 2 return 1 record and projectStatus eq 'active'" do
      [p1] = Project.list_project_by_status(nil, 2)
      assert p1.projectStatus == "active"
    end

    test "list_project_by_status where status is 'all' return 5is projectStatus not eq 'inactive'" do
      [p1, p2, p3, p4, p5, p6] = Project.list_project_by_status("all", 1)
      assert p1.projectStatus != "inactive"
      assert p2.projectStatus != "inactive"
      assert p3.projectStatus != "inactive"
      assert p4.projectStatus != "inactive"
      assert p5.projectStatus != "inactive"
      assert p6.projectStatus != "inactive"
    end

    test "list_project_by_status where status is 'complete' return list project is projectStatus eq 'complete' or 'expire'" do
      [p1, p2, p3, p4, p5] = Project.list_project_by_status("complete", 1)
      assert p1.projectStatus == "complete" || p1.projectStatus == "expire"
      assert p2.projectStatus == "complete" || p2.projectStatus == "expire"
      assert p3.projectStatus == "complete" || p3.projectStatus == "expire"
      assert p4.projectStatus == "complete" || p4.projectStatus == "expire"
      assert p5.projectStatus == "complete" || p5.projectStatus == "expire"
    end

    test "search project by 'SPB1' return project name 'สร้างสถานปฎิบัติธรรม สมเด็จพระสังฆราช (อมฺพรมหาเถร) วัดราชบพิธ'" do
      [p] = Project.search_project("SPB1")
      assert p.name == "สร้างสถานปฎิบัติธรรม สมเด็จพระสังฆราช (อมฺพรมหาเถร) วัดราชบพิธ"
    end

    test "search project by 'โครงการปล่อยปลาดุก' return project name 'โครงการปล่อยปลาดุกหน้าเขียง วันที่ 1 มีนาคม 2563'" do
      [p] = Project.search_project("โครงการปล่อยปลาดุก")
      assert p.name == "โครงการปล่อยปลาดุกหน้าเขียง วันที่ 1 มีนาคม 2563"
    end

    test "search project by 'บริจาค' return 3 projects" do
      [p1, p2, p3] = Project.search_project("บริจาค")
      assert p1.name == "บริจาคเครื่องอุปโภคบริโภคให้กับ Mercy Centre"
      assert p2.name == "บริจาคเครื่องอุปโภคบริโภคกับมูลนิธิโรงเรียนบ้านเด็กตาบอด"
      assert p3.name == "บริจาคเครื่องอุปโภคบริโภคกับมูลนิธิบ้านนกขมิ้น"
    end

    test "get_projects! returns the projects with given id" do
      project = projects_fixture()
      assert Project.get_projects!(project.id) == project
    end

    test "get_projects_detail! returns the projects by id and sum donation, donator" do
      [projects] = Project.get_projects_detail(5)
      assert projects.id == 5
      assert projects.donation == 150
      assert projects.donator == 5
    end

    test "get_projects_by_project_id returns the projects with given projectId" do
      project = projects_fixture()
      assert Project.get_projects_by_project_id(project.projectId) == project
    end

    test "Create Project and should be ok when response" do
      assert {:ok, %Projects{} = projects} = Project.create_projects(@valid_attrs)
    end

    test "update  project" do
      project = projects_fixture()

      assert {:ok, %Projects{} = projects} = Project.update_projects(project, @update_attrs);
      assert(projects.projectId =~ "update projectId")
    end

    test "insert or update project" do
      assert {:ok, %Projects{} = projects} = Project.insert_or_update_projects(projects_fixture(), @update_attrs)
    end

    test "Delete Project by pass project" do
      assert {:ok, %Projects{} = projects} = Project.delete_projects(projects_fixture())
    end
  end
end
