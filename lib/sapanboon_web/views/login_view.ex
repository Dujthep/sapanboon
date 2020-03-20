defmodule SapanboonWeb.LoginView do
  use SapanboonWeb, :view

  def render("show.json", %{login: login}) do
    %{data: render_one(login, SapanboonWeb.LoginView, "page.json")}
  end

  def render("page.json", %{login: login}) do
    %{
      status: "successfully",
      email: login.email,
      name: login.name
    }
  end
end
