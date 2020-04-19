defmodule SapanboonWeb.ErrorView do
  use SapanboonWeb, :view

  def render("500.html", _assigns) do
    render("500_page.html",%{})
  end

  def render("404.html", _assigns) do
    render("404_page.html",%{})
  end

  def render("404.json", _assigns) do
    %{errors: %{message: "Page not found"}}
  end

  def render("422.json", errors) do
    %{errors: %{message: "Bad request", errors: errors}}
  end

  def render("500.json", _assigns) do
    %{errors: %{message: "Internal server error"}}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end

end
