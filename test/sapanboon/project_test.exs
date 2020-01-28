# defmodule Sapanboon.ProjectTest do
#   use Sapanboon.DataCase

#   alias Sapanboon.Project

#   describe "project" do
#     alias Sapanboon.Project.Projects

#     @valid_attrs %{code: "some code", cover: "some cover", description: "some description", donation: 42, donator: 42, end_date: "2010-04-17T14:00:00Z", pledged_goal: 42, project_id: "some project_id", start_date: "2010-04-17T14:00:00Z", status: "some status", title: "some title"}
#     @update_attrs %{code: "some updated code", cover: "some updated cover", description: "some updated description", donation: 43, donator: 43, end_date: "2011-05-18T15:01:01Z", pledged_goal: 43, project_id: "some updated project_id", start_date: "2011-05-18T15:01:01Z", status: "some updated status", title: "some updated title"}
#     @invalid_attrs %{code: nil, cover: nil, description: nil, donation: nil, donator: nil, end_date: nil, pledged_goal: nil, project_id: nil, start_date: nil, status: nil, title: nil}

#     def projects_fixture(attrs \\ %{}) do
#       {:ok, projects} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Project.create_projects()

#       projects
#     end

#     test "list_project/0 returns all project" do
#       projects = projects_fixture()
#       assert Project.list_project() == [projects]
#     end

#     test "get_projects!/1 returns the projects with given id" do
#       projects = projects_fixture()
#       assert Project.get_projects!(projects.id) == projects
#     end

#     test "create_projects/1 with valid data creates a projects" do
#       assert {:ok, %Projects{} = projects} = Project.create_projects(@valid_attrs)
#       assert projects.code == "some code"
#       assert projects.cover == "some cover"
#       assert projects.description == "some description"
#       assert projects.donation == 42
#       assert projects.donator == 42
#       assert projects.end_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
#       assert projects.pledged_goal == 42
#       assert projects.project_id == "some project_id"
#       assert projects.start_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
#       assert projects.status == "some status"
#       assert projects.title == "some title"
#     end

#     test "create_projects/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Project.create_projects(@invalid_attrs)
#     end

#     test "update_projects/2 with valid data updates the projects" do
#       projects = projects_fixture()
#       assert {:ok, %Projects{} = projects} = Project.update_projects(projects, @update_attrs)
#       assert projects.code == "some updated code"
#       assert projects.cover == "some updated cover"
#       assert projects.description == "some updated description"
#       assert projects.donation == 43
#       assert projects.donator == 43
#       assert projects.end_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
#       assert projects.pledged_goal == 43
#       assert projects.project_id == "some updated project_id"
#       assert projects.start_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
#       assert projects.status == "some updated status"
#       assert projects.title == "some updated title"
#     end

#     test "update_projects/2 with invalid data returns error changeset" do
#       projects = projects_fixture()
#       assert {:error, %Ecto.Changeset{}} = Project.update_projects(projects, @invalid_attrs)
#       assert projects == Project.get_projects!(projects.id)
#     end

#     test "delete_projects/1 deletes the projects" do
#       projects = projects_fixture()
#       assert {:ok, %Projects{}} = Project.delete_projects(projects)
#       assert_raise Ecto.NoResultsError, fn -> Project.get_projects!(projects.id) end
#     end

#     test "change_projects/1 returns a projects changeset" do
#       projects = projects_fixture()
#       assert %Ecto.Changeset{} = Project.change_projects(projects)
#     end
#   end
# end
