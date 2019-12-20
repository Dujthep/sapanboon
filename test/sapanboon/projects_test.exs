defmodule Sapanboon.ProjectsTest do
  use Sapanboon.DataCase

  alias Sapanboon.Projects

  describe "project" do
    alias Sapanboon.Projects.Project

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projects.create_project()

      project
    end

    test "list_project/0 returns all project" do
      project = project_fixture()
      assert Projects.list_project() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Projects.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Projects.create_project(@valid_attrs)
      assert project.name == "some name"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = Projects.update_project(project, @update_attrs)
      assert project.name == "some updated name"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_project(project, @invalid_attrs)
      assert project == Projects.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Projects.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Projects.change_project(project)
    end
  end

  describe "project" do
    alias Sapanboon.Projects.Project

    @valid_attrs %{"": 42, code: "some code", description: "some description", donation: "some donation", donator: "some donator", end_date: "some end_date", image: "some image", pledged_goal: "some pledged_goal", project_id: "some project_id", start_date: "some start_date", status: "some status", title: "some title"}
    @update_attrs %{"": 43, code: "some updated code", description: "some updated description", donation: "some updated donation", donator: "some updated donator", end_date: "some updated end_date", image: "some updated image", pledged_goal: "some updated pledged_goal", project_id: "some updated project_id", start_date: "some updated start_date", status: "some updated status", title: "some updated title"}
    @invalid_attrs %{"": nil, code: nil, description: nil, donation: nil, donator: nil, end_date: nil, image: nil, pledged_goal: nil, project_id: nil, start_date: nil, status: nil, title: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projects.create_project()

      project
    end

    test "list_project/0 returns all project" do
      project = project_fixture()
      assert Projects.list_project() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Projects.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Projects.create_project(@valid_attrs)
      assert project. == 42
      assert project.code == "some code"
      assert project.description == "some description"
      assert project.donation == "some donation"
      assert project.donator == "some donator"
      assert project.end_date == "some end_date"
      assert project.image == "some image"
      assert project.pledged_goal == "some pledged_goal"
      assert project.project_id == "some project_id"
      assert project.start_date == "some start_date"
      assert project.status == "some status"
      assert project.title == "some title"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = Projects.update_project(project, @update_attrs)
      assert project. == 43
      assert project.code == "some updated code"
      assert project.description == "some updated description"
      assert project.donation == "some updated donation"
      assert project.donator == "some updated donator"
      assert project.end_date == "some updated end_date"
      assert project.image == "some updated image"
      assert project.pledged_goal == "some updated pledged_goal"
      assert project.project_id == "some updated project_id"
      assert project.start_date == "some updated start_date"
      assert project.status == "some updated status"
      assert project.title == "some updated title"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_project(project, @invalid_attrs)
      assert project == Projects.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Projects.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Projects.change_project(project)
    end
  end

  describe "project" do
    alias Sapanboon.Projects.Project

    @valid_attrs %{"": 42, code: "some code", cover: "some cover", description: "some description", donation: "some donation", donator: "some donator", end_date: "some end_date", pledged_goal: "some pledged_goal", project_id: "some project_id", start_date: "some start_date", status: "some status", title: "some title"}
    @update_attrs %{"": 43, code: "some updated code", cover: "some updated cover", description: "some updated description", donation: "some updated donation", donator: "some updated donator", end_date: "some updated end_date", pledged_goal: "some updated pledged_goal", project_id: "some updated project_id", start_date: "some updated start_date", status: "some updated status", title: "some updated title"}
    @invalid_attrs %{"": nil, code: nil, cover: nil, description: nil, donation: nil, donator: nil, end_date: nil, pledged_goal: nil, project_id: nil, start_date: nil, status: nil, title: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projects.create_project()

      project
    end

    test "list_project/0 returns all project" do
      project = project_fixture()
      assert Projects.list_project() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Projects.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Projects.create_project(@valid_attrs)
      assert project. == 42
      assert project.code == "some code"
      assert project.cover == "some cover"
      assert project.description == "some description"
      assert project.donation == "some donation"
      assert project.donator == "some donator"
      assert project.end_date == "some end_date"
      assert project.pledged_goal == "some pledged_goal"
      assert project.project_id == "some project_id"
      assert project.start_date == "some start_date"
      assert project.status == "some status"
      assert project.title == "some title"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = Projects.update_project(project, @update_attrs)
      assert project. == 43
      assert project.code == "some updated code"
      assert project.cover == "some updated cover"
      assert project.description == "some updated description"
      assert project.donation == "some updated donation"
      assert project.donator == "some updated donator"
      assert project.end_date == "some updated end_date"
      assert project.pledged_goal == "some updated pledged_goal"
      assert project.project_id == "some updated project_id"
      assert project.start_date == "some updated start_date"
      assert project.status == "some updated status"
      assert project.title == "some updated title"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_project(project, @invalid_attrs)
      assert project == Projects.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Projects.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Projects.change_project(project)
    end
  end
end
