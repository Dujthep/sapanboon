defmodule SapanboonWeb.Router do
  use SapanboonWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SapanboonWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/project", ProjectsController

  end

  # Other scopes may use custom stacks.
  # scope "/api", SapanboonWeb do
  #   pipe_through :api
  # end
end
